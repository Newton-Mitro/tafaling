import 'dart:convert';
import 'dart:io';

import 'package:tafaling/core/network_old/api_service.dart';
import 'package:tafaling/core/network_old/auth_api_service.dart';
import 'package:tafaling/core/utils/shared_prefs.dart';
import 'package:tafaling/features/auth/data/models/auth_user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthUserModel> login(String email, String password);
  Future<String> register(
      String name, String email, String password, String confirmPassword);
  Future<String> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;
  final AuthApiService authApiService;

  AuthRemoteDataSourceImpl(
      {required this.apiService, required this.authApiService});

  @override
  Future<AuthUserModel> login(String email, String password) async {
    try {
      final response = await apiService.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final data = response.data!['data'];
        var user = data['user'];
        // Store tokens
        await SharedPrefs.saveUser(jsonEncode(user));
        await SharedPrefs.saveUserId(user['user_id']);
        await SharedPrefs.saveAccessToken(data['access_token']);
        await SharedPrefs.saveRefreshToken(data['refresh_token']);
        var res = AuthUserModel.fromJson(data);
        return res;
      } else {
        throw Exception('Unexpected response: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> register(String name, String email, String password,
      String confirmPassword) async {
    try {
      final response = await apiService.post(
        '/auth/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': confirmPassword
        },
      );

      if (response.statusCode == 201) {
        final data = response.data!['message'];
        return data;
      } else {
        throw Exception('Failed to register');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> logout() async {
    final response = await authApiService.get(
      '/auth/logout',
    );
    if (response.statusCode == 201) {
      return response.data;
    } else {
      throw Exception('Failed to register');
    }
  }
}
