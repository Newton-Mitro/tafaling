import 'dart:io';

import 'package:tafaling/core/network_old/api_service.dart';
import 'package:tafaling/core/network_old/auth_api_service.dart';
import 'package:tafaling/core/utils/app_shared_pref.dart';
import 'package:tafaling/features/auth/data/models/auth_user_model.dart';
import 'package:tafaling/features/user/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthUserModel> login(String? email, String? password);
  Future<AuthUserModel> register(
      String name, String email, String password, String confirmPassword);
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;
  final AuthApiService authApiService;

  AuthRemoteDataSourceImpl(
      {required this.apiService, required this.authApiService});

  @override
  Future<AuthUserModel> login(String? email, String? password) async {
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
        AuthUserModel res = AuthUserModel.fromJson(data);
        await AppSharedPref.setAuthUser(res.user as UserModel);
        await AppSharedPref.setAccessToken(res.accessToken);
        await AppSharedPref.setRefreshToken(res.refreshToken);
        return res;
      } else {
        throw Exception('Login failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthUserModel> register(String name, String email, String password,
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
  Future<void> logout() async {
    await authApiService.get(
      '/auth/logout',
    );
  }
}
