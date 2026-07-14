import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rafiq/core/errors/server_failure.dart';
import 'package:rafiq/core/networking/interceptors/cookie_logger_interceptor.dart';
import 'package:rafiq/core/networking/interceptors/refresh_interceptor.dart';
import 'package:uuid/uuid.dart';
import 'api_constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_cookie_store/hive_cookie_store.dart';
import 'package:hive_ce/hive.dart' as hive_ce;

class ApiService {
  static final ApiService instance = ApiService._internal();
  final Dio _dio = Dio();
  final Uuid _uuid = const Uuid();
  late final PersistCookieJar _cookieJar;

  ApiService._internal() {
    _dio.options = BaseOptions(
      baseUrl: ApiConstants.baseURL,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 60 * 5),
    );
  }

  Future<void> initialize() async {
    // 1. Initialize Hive for Flutter
    await Hive.initFlutter();

    // 2. Initialize hive_ce for the cookie store (since hive_cookie_store uses hive_ce)
    final appDocDir = await getApplicationDocumentsDirectory();
    hive_ce.Hive.init(appDocDir.path);

    // 3. Setup HiveCookieStorage with encryption cipher
    // We use EncryptionHelper.generateCipher directly to handle key creation and persistence.
    final cipher = await EncryptionHelper.generateCipher(key: 'secure_cookie_encryption_key');

    // 4. Eagerly open/verify the box as Box<String> to match HiveCookieStorage's type definition.
    // If opening fails (e.g., due to key/decryption mismatch), delete and recreate it.
    try {
      await hive_ce.Hive.openBox<String>('secure_cookies_box', encryptionCipher: cipher);
    } catch (e) {
      if (kDebugMode) {
        print('⚠️ Failed to open secure_cookies_box: $e. Recreating...');
      }
      try {
        await hive_ce.Hive.deleteBoxFromDisk('secure_cookies_box');
      } catch (deleteError) {
        if (kDebugMode) {
          print('⚠️ Failed to delete secure_cookies_box from disk: $deleteError');
        }
      }
      await hive_ce.Hive.openBox<String>('secure_cookies_box', encryptionCipher: cipher);
    }

    final storage = HiveCookieStorage(
      boxName: 'secure_cookies_box',
      encryptionCipher: cipher,
    );

    _cookieJar = PersistCookieJar(
      storage: storage,
      ignoreExpires: false, // Respect cookie expiration dates
    );

    // Add cookie manager to handle cookies automatically
    _dio.interceptors.add(CookieManager(_cookieJar));

    // add refresh interceptor to handle 401 errors and execute the request again
    _dio.interceptors.add(RefreshInterceptor(dio: _dio));

    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
          compact: true,
          maxWidth: 90, // keeps lines readable in consoles
        ),
      );

      _dio.interceptors.add(CookieLoggerInterceptor(_cookieJar));
    }
  }

  // Clear all cookies (useful for logout)
  Future<void> clearCookies() async {
    await _cookieJar.deleteAll();
    if (kDebugMode) {
      print('🍪 ALL COOKIES CLEARED FROM STORAGE');
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final requestOptions = options ?? Options();
      requestOptions.headers ??= {};
      requestOptions.headers!['Idempotency-Key'] = _uuid.v4();

      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: requestOptions,
      );
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  Future<Response> put(String path, {dynamic data, Options? options}) async {
    try {
      final requestOptions = options ?? Options();
      requestOptions.headers ??= {};
      requestOptions.headers!['Idempotency-Key'] = _uuid.v4();

      return await _dio.put(path, data: data, options: requestOptions);
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  Future<Response> patch(String path, {dynamic data, Options? options}) async {
    try {
      final requestOptions = options ?? Options();
      requestOptions.headers ??= {};
      requestOptions.headers!['Idempotency-Key'] = _uuid.v4();

      return await _dio.patch(path, data: data, options: requestOptions);
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  Future<Response> delete(String path, {dynamic data, Options? options}) async {
    try {
      final requestOptions = options ?? Options();
      requestOptions.headers ??= {};
      requestOptions.headers!['Idempotency-Key'] = _uuid.v4();
      return await _dio.delete(path, data: data, options: requestOptions);
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  Future<String> downloadFile(String url, String fileName) async {
    try {
      if (Platform.isAndroid) {
        if (await Permission.manageExternalStorage.request().isDenied) {
          await Permission.storage.request();
        }
      }

      String basePath = "";
      if (Platform.isAndroid) {
        basePath = "/storage/emulated/0/Download";
        if (!await Directory(basePath).exists()) {
          await getExternalStorageDirectory();
        }
      } else {
        final dir = await getDownloadsDirectory();
        basePath = dir!.path;
      }

      final rafiqDir = Directory("$basePath/rafiq");
      if (!await rafiqDir.exists()) {
        await rafiqDir.create(recursive: true);
      }

      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String savePath = "${rafiqDir.path}/${timestamp}_$fileName";

      await _dio.download(url, savePath);
      return savePath;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
