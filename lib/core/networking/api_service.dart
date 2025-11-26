import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'api_constants.dart';

class ApiService {
  static final ApiService instance = ApiService._internal();
  final Dio _dio = Dio();
  late final PersistCookieJar _cookieJar;

  ApiService._internal() {
    _dio.options = BaseOptions(
      baseUrl: ApiConstants.baseURL,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 60 * 5),
    );
  }

  Future<void> initialize() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final cookiePath = '${appDocDir.path}/.cookies/';

    _cookieJar = PersistCookieJar(
      storage: FileStorage(cookiePath),
      ignoreExpires: false, // Respect cookie expiration dates
    );

    // Add cookie manager to handle cookies automatically
    _dio.interceptors.add(CookieManager(_cookieJar));

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

      // This interceptor logs cookie information for debugging purposes
      _dio.interceptors.add(
        InterceptorsWrapper(
          onResponse: (response, handler) async {
            // Log cookies received from the server
            final cookies = await _cookieJar.loadForRequest(
              response.requestOptions.uri,
            );
            if (cookies.isNotEmpty) {
              if (kDebugMode) {
                print(
                  '🍪 COOKIES RECEIVED & SAVED: ${cookies.length} cookie(s)',
                );
              }
              for (var cookie in cookies) {
                if (kDebugMode) {
                  print('  ├─ Name: ${cookie.name}');
                  print('  ├─ Value: ${cookie.value}');
                  print('  ├─ Domain: ${cookie.domain}');
                  print('  ├─ Path: ${cookie.path}');
                  print('  └─ Expires: ${cookie.expires}');
                }
              }
            }
            return handler.next(response);
          },
          onRequest: (options, handler) async {
            // Log cookies being sent with the request
            final cookies = await _cookieJar.loadForRequest(options.uri);
            if (cookies.isNotEmpty) {
              debugPrint(
                '🍪 COOKIES SENT (from storage): ${cookies.length} cookie(s)',
              );
              for (var cookie in cookies) {
                debugPrint('  ├─ ${cookie.name}: ${cookie.value}');
              }
            }
            return handler.next(options);
          },
        ),
      );
    }
  }

  // Clear all cookies (useful for logout)
  Future<void> clearCookies() async {
    await _cookieJar.deleteAll();
    if (kDebugMode) {
      print('🍪 ALL COOKIES CLEARED FROM STORAGE');
    }
  }

  // Get all cookies for debugging
  Future<List<Cookie>> getCookies(Uri uri) async {
    return await _cookieJar.loadForRequest(uri);
  }

  Future<Response> post(String path, {dynamic data, Options? options}) async {
    try {
      return await _dio.post(path, data: data, options: options);
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  Future<Response> put(String path, {dynamic data, Options? options}) async {
    try {
      return await _dio.put(path, data: data, options: options);
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  Future<Response> delete(String path, {dynamic data, Options? options}) async {
    try {
      return await _dio.delete(path, data: data, options: options);
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  Future<String> downloadFile(String url, String fileName) async {
    try {
      Directory? dir;
      if (Platform.isAndroid) {
        dir = Directory('/storage/emulated/0/Download');
        if (!await dir.exists()) {
          dir = await getExternalStorageDirectory();
        }
      } else {
        dir = await getDownloadsDirectory();
      }

      dir ??= await getApplicationDocumentsDirectory();

      final rafiqDir = Directory('${dir.path}/rafiq');
      if (!await rafiqDir.exists()) {
        await rafiqDir.create(recursive: true);
      }

      final savePath = '${rafiqDir.path}/$fileName';
      await _dio.download(url, savePath);
      return savePath;
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    } catch (e) {
      throw Exception('Download failed: $e');
    }
  }

  String _handleError(DioException e) {
    if (e.response?.statusCode == 401) {
      return 'Unauthorized. Please login again.';
    }
    if (e.response?.statusCode == 404) return 'Endpoint not found.';
    if (e.type == DioExceptionType.connectionTimeout) {
      return 'Connection timeout.';
    }
    return e.message ?? 'Unexpected error.';
  }
}
