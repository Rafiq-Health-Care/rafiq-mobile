import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CookieLoggerInterceptor extends InterceptorsWrapper {
  final CookieJar cookieJar;
  CookieLoggerInterceptor(this.cookieJar);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (kDebugMode) {
      final cookies = await cookieJar.loadForRequest(options.uri);
      if (cookies.isNotEmpty) {
        print('🍪 COOKIES SENT: ${cookies.length} cookie(s)');
        for (var cookie in cookies) {
          print('  ├─ ${cookie.name}: ${cookie.value}');
        }
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (kDebugMode) {
      final cookies = await cookieJar.loadForRequest(
        response.requestOptions.uri,
      );
      if (cookies.isNotEmpty) {
        print('🍪 COOKIES RECEIVED & SAVED: ${cookies.length} cookie(s)');
        for (var cookie in cookies) {
          print('  ├─ Name: ${cookie.name}');
          print('  ├─ Value: ${cookie.value}');
          print('  ├─ Domain: ${cookie.domain}');
          print('  ├─ Path: ${cookie.path}');
          print('  └─ Expires: ${cookie.expires}');
        }
      }
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print('🍪 Cookie Error: ${err.message}');
    }
    handler.next(err);
  }
}
