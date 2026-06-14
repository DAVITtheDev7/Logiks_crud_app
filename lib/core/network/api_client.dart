import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiClient {
  late final Dio dio;

  ApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.restful-api.dev',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint('[REQUEST] ${options.method} ${options.uri}');
          if (options.data != null) {
            debugPrint('Request Data: ${options.data}');
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint(
            '[RESPONSE] Status: ${response.statusCode} | ${response.requestOptions.uri}',
          );
          debugPrint('[Response] Data: ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          debugPrint(
            '[ERROR] Status: ${e.response?.statusCode} | ${e.requestOptions.uri}',
          );
          debugPrint('Message: ${e.message}');
          if (e.response?.data != null) {
            debugPrint('Server Error Data: ${e.response?.data}');
          }
          return handler.next(e);
        },
      ),
    );
  }
}
