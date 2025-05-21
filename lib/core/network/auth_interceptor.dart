import 'dart:io';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:tafaling/core/constants/api_config.dart';
import 'package:tafaling/features/auth/data/data_sources/auth_data_source.dart';
import 'package:tafaling/features/auth/data/models/auth_user_model.dart';
import 'package:tafaling/my_app.dart';
import 'package:tafaling/routes/route_name.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final AuthLocalDataSource authLocalDataSource;

  late String? accessToken;
  late String? refreshToken;

  AuthInterceptor({required this.dio, required this.authLocalDataSource});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final authUser = await authLocalDataSource.getAuthUser();
      accessToken = authUser.accessToken;
      refreshToken = authUser.refreshToken;
    } catch (e) {
      accessToken = null;
      refreshToken = null;
    }

    options.headers['Accept'] = 'application/json';

    if (accessToken != null && accessToken!.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
      if (JwtDecoder.isExpired(accessToken!)) {
        final newRefreshToken = await _handleTokenRefresh();
        if (newRefreshToken != null) {
          options.headers["Authorization"] = "Bearer $newRefreshToken";
        }
      }
    }

    handler.next(options);
  }

  Future<String?> _handleTokenRefresh() async {
    try {
      if (refreshToken == null || JwtDecoder.isExpired(refreshToken!)) {
        await authLocalDataSource.clearAuthUser(); // clear user from storage
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          RoutesName.root,
          (route) => false,
        );
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
          await authLocalDataSource.setAuthUser(res);
          return res.accessToken;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
