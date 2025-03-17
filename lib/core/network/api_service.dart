import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tafaling/core/constants/api_config.dart';
import 'package:tafaling/core/errors/exceptions.dart';
import 'package:tafaling/core/utils/app_shared_pref.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiConfig.baseUrl,
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
      var accessToken = await AppSharedPref.getAccessToken();
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
    final statusCode = e.response?.statusCode;
    switch (statusCode) {
      case HttpStatus.badRequest:
        final Map<String, dynamic>? errorResponse = e.response?.data;
        if (errorResponse != null) {
          final errors = errorResponse['errors'] as Map<String, dynamic>;
          throw ValidationException(
            errors: errors,
          );
        }
        break;
      case HttpStatus.unauthorized:
        throw UnauthorizedException();
      case HttpStatus.forbidden:
        throw ForbiddenException();
      case HttpStatus.internalServerError:
        throw ServerException();
      default:
        throw ServerException();
    }
  }
}
