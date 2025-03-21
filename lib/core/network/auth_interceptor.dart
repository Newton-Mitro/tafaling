import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:tafaling/core/constants/constants.dart';
import 'package:tafaling/core/index.dart';
import 'package:tafaling/features/auth/data/models/auth_user_model.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final LocalStorage localStorage;
  late String? accessToken;
  late String? refreshToken;

  AuthInterceptor({required this.dio, required this.localStorage});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Retrieve tokens
    accessToken = await localStorage.getString(Constants.accessTokenKey);

    options.headers['Accept'] = 'application/json';
    // options.validateStatus = (status) => status != null && status < 500;

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';

      // Check if token is expired and log out if needed
      if (JwtDecoder.isExpired(accessToken!)) {
        final newRefreshToken = await _handleTokenRefresh();
        if (newRefreshToken != null) {
          options.headers["Authorization"] = "Bearer $newRefreshToken";

          // Repeat the failed request with the new token
          handler.next(options);
        }
      }
    }

    // Ensure only one handler call
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final newToken = await _handleTokenRefresh();
      if (newToken != null) {
        err.requestOptions.headers["Authorization"] = "Bearer $newToken";

        // Repeat the failed request with the new token
        final retryResponse = await dio.fetch(err.requestOptions);
        return handler.resolve(retryResponse);
      }
    }
    return handler.next(err);
  }

  Future<String?> _handleTokenRefresh() async {
    try {
      refreshToken = await localStorage.getString(Constants.refreshTokenKey);

      if (refreshToken == null) return null;
      if (JwtDecoder.isExpired(refreshToken!)) {
        await _logout();
      }

      final response = await dio.get(
        '${ApiConfig.baseUrl}/auth/refresh',
        options: Options(
          headers: {
            'Authorization': 'Bearer $refreshToken',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == HttpStatus.ok) {
        final data = response.data!['data'];
        var res = AuthUserModel.fromJson(data);
        await localStorage.saveString(
          Constants.accessTokenKey,
          res.accessToken,
        );
        await localStorage.saveString(
          Constants.refreshTokenKey,
          res.refreshToken,
        );
        return res.accessToken;
      } else {
        await _logout();
      }
    } catch (e) {
      await _logout();
    }
    return null;
  }

  Future<void> _logout() async {
    await localStorage.remove(Constants.accessTokenKey);
    await localStorage.remove(Constants.refreshTokenKey);
    await localStorage.remove(Constants.authUserKey);
    throw UnauthorizedException();
  }
}
