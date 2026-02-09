import 'package:dio/dio.dart';
import 'package:rafiq/core/networking/api_constants.dart';

class RefreshInterceptor extends QueuedInterceptor {
  final Dio dio;
  bool _isRefreshing = false;

  RefreshInterceptor({required this.dio});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401 ||
        _isRefreshRequest(err.requestOptions) ||
        _isRefreshing) {
      return handler.next(err);
    }

    _isRefreshing = true;

    try {
      await _refreshToken();
      final response = await _retryRequest(err.requestOptions);
      handler.resolve(response);
    } catch (e) {
      handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }

  bool _isRefreshRequest(RequestOptions options) {
    return options.path.contains(ApiConstants.authRefresh) ||
        options.path.contains(ApiConstants.login);
  }

  Future<void> _refreshToken() async {
    await dio.post(ApiConstants.authRefresh);
  }

  Future<Response> _retryRequest(RequestOptions requestOptions) async {
    return dio.fetch(requestOptions);
  }
}
