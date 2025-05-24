import 'package:dio/dio.dart';
import 'package:tafaling/core/constants/api_config.dart';
import 'package:tafaling/core/services/logging/logger_service.dart';
import 'package:tafaling/core/network/auth_interceptor.dart';
import 'package:tafaling/core/network/logger_interceptor.dart';
import 'package:tafaling/features/auth/data/data_sources/auth_data_source.dart';

class ApiService {
  final Dio _dio;
  final AuthLocalDataSource authLocalDataSource;
  final LoggerService loggerService;

  ApiService({required this.authLocalDataSource, required this.loggerService})
    : _dio = Dio() {
    _dio.options = BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(seconds: 50),
      receiveTimeout: const Duration(seconds: 50),
    );
    _dio.interceptors.addAll([
      AuthInterceptor(dio: _dio, authLocalDataSource: authLocalDataSource),
      LoggerInterceptor(loggerService: loggerService),
    ]);
  }

  Future<Response> get(
    String endpoint, {
    dynamic queryParameters,
    Options? options,
  }) async {
    return _performRequest(
      () => _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: options ?? Options(),
      ),
    );
  }

  Future<Response> post(
    String endpoint, {
    required dynamic data,
    Options? options,
  }) async {
    return _performRequest(
      () => _dio.post(endpoint, data: data, options: options ?? Options()),
    );
  }

  Future<Response> put(
    String endpoint, {
    required Map<String, dynamic> data,
    Options? options,
  }) async {
    return _performRequest(
      () => _dio.put(endpoint, data: data, options: options ?? Options()),
    );
  }

  Future<Response> patch(
    String endpoint, {
    required Map<String, dynamic> data,
    Options? options,
  }) async {
    return _performRequest(
      () => _dio.patch(endpoint, data: data, options: options ?? Options()),
    );
  }

  Future<Response> delete(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _performRequest(
      () => _dio.delete(
        endpoint,
        queryParameters: queryParameters,
        options: options ?? Options(),
      ),
    );
  }

  Future<Response> _performRequest(Future<Response> Function() request) async {
    try {
      return await request();
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
