import 'package:dio/dio.dart';
import 'package:tafaling/core/constants/api_config.dart';
import 'package:tafaling/core/network/auth_interceptor.dart';

class ApiClient {
  static Dio dio() {
    Dio dio = Dio(
      BaseOptions(
          baseUrl: ApiConfig.baseUrl,
          headers: {
            'Content-Type': 'application/json; charset=UTP-8',
          },
          extra: {
            'ignoreAuth': true,
          },
          responseType: ResponseType.json,
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 30)),
    )
      ..interceptors.add(XAuthInterceptor(dio: Dio()))
      ..interceptors.add(LogInterceptor());
    return dio;
  }
}
