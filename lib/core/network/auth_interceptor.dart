import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:tafaling/core/bloc/app_state_bloc.dart';
import 'package:tafaling/core/constants/api_config.dart';
import 'package:tafaling/core/constants/constants.dart';
import 'package:tafaling/core/utils/local_storage.dart';
import 'package:tafaling/features/auth/data/models/auth_user_model.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final LocalStorage localStorage;
  final AppStateBloc appStateBloc;

  late String? accessToken;
  late String? refreshToken;

  AuthInterceptor({
    required this.dio,
    required this.localStorage,
    required this.appStateBloc,
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    accessToken = await localStorage.getString(Constants.accessTokenKey);

    options.headers['Accept'] = 'application/json';
    options.headers['Authorization'] = 'Bearer $accessToken';

    if (accessToken != null) {
      if (JwtDecoder.isExpired(accessToken!)) {
        final newRefreshToken = await _handleTokenRefresh();
        if (newRefreshToken != null) {
          options.headers["Authorization"] = "Bearer $newRefreshToken";
        }
      }
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final newToken = await _handleTokenRefresh();
      if (newToken != null) {
        err.requestOptions.headers["Authorization"] = "Bearer $newToken";

        try {
          final retryResponse = await dio.fetch(err.requestOptions);
          return handler.resolve(retryResponse);
        } catch (e) {
          return handler.next(err);
        }
      }
    }
    return handler.next(err);
  }

  Future<String?> _handleTokenRefresh() async {
    try {
      refreshToken = await localStorage.getString(Constants.refreshTokenKey);
      if (refreshToken == null || JwtDecoder.isExpired(refreshToken!)) {
        await _logout();
        return null;
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
        final data = response.data?['data'];
        if (data != null) {
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
        }
      }

      await _logout();
      return null;
    } catch (e) {
      await _logout();
      return null;
    }
  }

  Future<void> _logout() async {
    await localStorage.remove(Constants.accessTokenKey);
    await localStorage.remove(Constants.refreshTokenKey);
    await localStorage.remove(Constants.authUserKey);
    appStateBloc.add(LogoutEvent());
  }
}
