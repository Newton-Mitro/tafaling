import 'package:dio/dio.dart';
import 'package:tafaling/core/constants/api_config.dart';
import 'package:tafaling/core/errors/exceptions.dart';
import 'package:tafaling/core/network_old/dio_interceptor.dart';

class AuthApiService {
  final Dio _dio;

  AuthApiService() : _dio = Dio() {
    _dio.options = BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(seconds: 50),
      receiveTimeout: const Duration(seconds: 50),
    );
    _dio.interceptors.add(AuthInterceptor(_dio));
  }

  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    return _performRequest(() => _dio.get(
          endpoint,
          queryParameters: queryParameters,
          options: options ?? Options(),
        ));
  }

  Future<Response> post(String endpoint,
      {required Map<String, dynamic> data, Options? options}) async {
    return _performRequest(
        () => _dio.post(endpoint, data: data, options: options ?? Options()));
  }

  Future<Response> put(String endpoint,
      {required Map<String, dynamic> data, Options? options}) async {
    return _performRequest(
        () => _dio.put(endpoint, data: data, options: options ?? Options()));
  }

  Future<Response> patch(String endpoint,
      {required Map<String, dynamic> data, Options? options}) async {
    return _performRequest(
        () => _dio.patch(endpoint, data: data, options: options ?? Options()));
  }

  Future<Response> delete(String endpoint,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    return _performRequest(() => _dio.delete(
          endpoint,
          queryParameters: queryParameters,
          options: options ?? Options(),
        ));
  }

  /// Helper method to execute a request and handle errors
  Future<Response> _performRequest(Future<Response> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  /// Custom error handling based on DioException
  void _handleDioError(DioException e) {
    final statusCode = e.response?.statusCode;

    switch (statusCode) {
      case 400:
        final Map<String, dynamic>? errorResponse = e.response?.data;
        if (errorResponse != null) {
          final errors = errorResponse['errors'] as Map<String, dynamic>;
          throw ValidationException(errors);
        }
        break;
      case 401:
        throw Exception('Unauthorized: Please check your credentials.');
      case 403:
        throw Exception('Forbidden: Access is denied.');
      case 500:
        throw Exception(
            e.response != null ? e.response?.data['error'] : "error occurred");
      default:
        throw Exception(
            'Network error: ${statusCode ?? 'Unknown'} - ${e.message}');
    }
  }
}
