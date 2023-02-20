import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../config/env/env.dart';
import 'interceptors/auth_interceptor.dart';

class CustomDio extends DioForNative {
  CustomDio()
      : super(
          BaseOptions(
            baseUrl: Env.backendBaseUrl,
            connectTimeout: const Duration(seconds: 5),
            receiveTimeout: const Duration(seconds: 30),
          ),
        ) {
    interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
    _authInterceptor = AuthInterceptor();

    httpClientAdapter = BrowserHttpClientAdapter();
  }

  late AuthInterceptor _authInterceptor;

  CustomDio auth() {
    interceptors.add(_authInterceptor);
    return this;
  }

  CustomDio unAuth() {
    interceptors.remove(_authInterceptor);
    return this;
  }
}
