import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:tafaling/configs/routes/route_name.dart';
import 'package:tafaling/core/utils/app_shared_pref.dart';
import 'package:tafaling/features/auth/data/models/auth_user_model.dart';
import 'package:tafaling/my_app.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  late String? accessToken;
  late String? refreshToken;

  AuthInterceptor(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Retrieve tokens
    accessToken = await AppSharedPref.getAccessToken();

    options.headers['Accept'] = 'application/json';
    options.validateStatus = (status) => status != null && status < 500;

    if (accessToken != null && !JwtDecoder.isExpired(accessToken!)) {
      options.headers['Authorization'] = 'Bearer $accessToken';
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
        final response = await dio.fetch(err.requestOptions);
        return handler.resolve(response);
      }
    }
    return handler.next(err);
  }

  Future<String?> _handleTokenRefresh() async {
    try {
      refreshToken = await AppSharedPref.getRefreshToken();
      if (refreshToken == null) return null;
      final response = await dio.get(
        'https://devapi.tafaling.com/api/auth/refresh',
        options: Options(
          headers: {
            'Authorization': 'Bearer $refreshToken',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data!['data'];
        var res = AuthUserModel.fromJson(data);
        await AppSharedPref.setAccessToken(res.accessToken);
        await AppSharedPref.setRefreshToken(res.refreshToken);

        String? newAccessToken = res.accessToken;
        return newAccessToken;
      }
    } on DioException {
      await AppSharedPref.removeAuthUser();
      await AppSharedPref.removeAccessToken();
      await AppSharedPref.removeRefreshToken();
      navigatorKey.currentState?.pushReplacementNamed(RoutesName.loginPage);
    }
    return null;
  }
}
