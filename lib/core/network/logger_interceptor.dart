import 'package:dio/dio.dart';
import 'dart:convert';

class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("📤 REQUEST: ${options.method} ${options.uri}");
    print("Headers: ${options.headers}");
    if (options.data != null) {
      try {
        print("Body: ${jsonEncode(options.data)}");
      } catch (_) {
        print("Body: ${options.data}");
      }
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        "📥 RESPONSE [${response.statusCode}]: ${response.requestOptions.uri}");
    print("Headers: ${response.headers}");
    try {
      print("Data: ${jsonEncode(response.data)}");
    } catch (_) {
      print("Data: ${response.data}");
    }
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print("❌ ERROR [${err.response?.statusCode}]: ${err.requestOptions.uri}");
    print("Message: ${err.message}");
    if (err.response != null) {
      try {
        print("Error Data: ${jsonEncode(err.response?.data)}");
      } catch (_) {
        print("Error Data: ${err.response?.data}");
      }
    }
    return handler.next(err);
  }
}
