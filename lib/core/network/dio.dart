import 'package:dio/dio.dart';

class DioProvider {
  static Dio createDioWithHeader() {
    Dio dio = Dio(BaseOptions(baseUrl: "https://api.example.com"));
    return dio;
  }
}
