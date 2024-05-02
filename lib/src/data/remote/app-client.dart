import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

import 'middle-handler/logger_interceptor.dart';


//Config header, base option
@Singleton()
 class AppClient {
  final Dio _dio = Dio();
  final LoggerInterceptor _loggerInterceptor = LoggerInterceptor();
  Dio get dio => _dio;
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json, text/plain, */*',
  };

  AppClient() {
    BaseOptions options = BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(milliseconds:  60 * 1000), // 60 seconds
      receiveTimeout: const Duration(milliseconds:  60 * 1000), // 60 seconds
      headers: headers,
    );
    _dio.options = options;
    _dio.interceptors.add(_loggerInterceptor);
  }

  Dio dioAuth(String accessToken) {
    _dio.options.headers['Authorization'] = 'Bearer $accessToken';
    return _dio;
  }

  Dio dioNonAuth() {
    _dio.options.headers = headers;
    return _dio;
  }
}
