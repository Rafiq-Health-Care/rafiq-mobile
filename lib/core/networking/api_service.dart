import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'api_constants.dart';

class ApiService {
  static final ApiService instance = ApiService._internal();
  final Dio dio = Dio();
  String? _token;

  ApiService._internal() {
    dio.options = BaseOptions(
      baseUrl: ApiConstants.baseURL,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      // headers: {
      //   // 'Content-Type': 'application/json',
      //   'Accept': 'application/json',
      // },
    );

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(request: true, responseBody: true, error: true),
      );
    }

    _setupAuthInterceptor();
  }

  void _setupAuthInterceptor() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (_token != null && _token!.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $_token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  void setAuthToken(String token) {
    _token = token;
  }

  Future<Response> post(String path, {dynamic data ,Options? options}) async {
    try {
      return await dio.post(path, data: data,options: options);
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw Exception(_handleError(e));
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
