import 'package:dio/dio.dart';
import 'package:tafaling/core/errors/exceptions.dart';
import 'package:tafaling/core/utils/shared_prefs.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://devapi.tafaling.com/api',
    connectTimeout: const Duration(seconds: 50),
    receiveTimeout: const Duration(seconds: 50),
  ));

  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    return _performRequest(() =>
        _dio.get(endpoint, queryParameters: queryParameters, options: options));
  }

  Future<Response> post(String endpoint,
      {required Map<String, dynamic> data, Options? options}) async {
    return _performRequest(
        () => _dio.post(endpoint, data: data, options: options));
  }

  Future<Response> put(String endpoint,
      {required Map<String, dynamic> data, Options? options}) async {
    return _performRequest(
        () => _dio.put(endpoint, data: data, options: options));
  }

  Future<Response> patch(String endpoint,
      {required Map<String, dynamic> data, Options? options}) async {
    return _performRequest(
        () => _dio.patch(endpoint, data: data, options: options));
  }

  Future<Response> delete(String endpoint,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    return _performRequest(() => _dio.delete(endpoint,
        queryParameters: queryParameters, options: options));
  }

  Future<Response> _performRequest(Future<Response> Function() request,
      {Options? options}) async {
    try {
      String? accessToken = await SharedPrefs.getAccessToken();
      options ??= Options();
      options.headers ??= {};
      if (accessToken != null) {
        options.headers!['Authorization'] = 'Bearer $accessToken';
      }

      final response = await request();
      return response;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  void _handleDioError(DioException e) {
    switch (e.response?.statusCode) {
      case 400:
        final Map<String, dynamic>? errorResponse = e.response?.data;
        if (errorResponse != null) {
          final errors = errorResponse['errors'] as Map<String, dynamic>;
          throw ValidationException(errors);
        }
        break;
      case 401:
        // Potentially handle token expiration here
        throw Exception('Unauthorized: Please check your credentials.');
      case 403:
        throw Exception('Forbidden: Access is denied.');
      case 500:
        throw Exception(
            e.response != null ? e.response?.data['error'] : "error occurred");
      default:
        throw Exception(
            'Network error: ${e.response?.statusCode ?? 'Unknown'} - ${e.message}');
    }
  }
}
