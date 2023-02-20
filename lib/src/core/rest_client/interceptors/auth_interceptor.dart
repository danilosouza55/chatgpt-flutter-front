import 'dart:io';

import 'package:dio/dio.dart';

import '../../config/env/env.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = Env.instance['backend_token'];

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
      options.headers['Content-Type'] = 'application/json';
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == HttpStatus.unauthorized) {
    } else {
      return handler.next(err);
    }
  }
}
