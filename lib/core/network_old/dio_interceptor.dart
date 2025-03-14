import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:tafaling/configs/routes/route_name.dart';
import 'package:tafaling/core/utils/app_shared_pref.dart';
import 'package:tafaling/features/auth/data/models/auth_user_model.dart';
import 'package:tafaling/my_app.dart';

class AuthInterceptor extends Interceptor {
  late String? accessToken;
  late String? refreshToken;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Retrieve tokens
    accessToken = await AppSharedPref.getAccessToken();
    refreshToken = await AppSharedPref.getRefreshToken();

    options.headers['Accept'] = 'application/json';
    options.validateStatus = (status) => status != null && status < 500;

    if (accessToken != null && !JwtDecoder.isExpired(accessToken!)) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    } else {
      await AppSharedPref.removeAccessToken();
      await AppSharedPref.removeRefreshToken();
      await AppSharedPref.removeAuthUser();
    }

    // Ensure only one handler call
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 401) {
      _handleTokenRefresh(response.requestOptions, handler);
    } else {
      handler.next(response);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      _handleTokenRefresh(err.requestOptions, handler);
    } else {
      handler.next(err);
    }
  }

  Future<void> _handleTokenRefresh(RequestOptions options, handler) async {
    try {
      final response = await Dio().get(
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
        // Retry the original request with the new access token
        options.headers['Authorization'] = 'Bearer $newAccessToken';
        final retryResponse = await Dio().fetch(options);
        handler.resolve(retryResponse);
      } else {
        await AppSharedPref.removeAuthUser();
        await AppSharedPref.removeAccessToken();
        await AppSharedPref.removeRefreshToken();
        navigatorKey.currentState?.pushReplacementNamed(RoutesName.loginPage);
        handler
            .reject(DioException(requestOptions: options, response: response));
      }
    } on DioException {
      await AppSharedPref.removeAuthUser();
      await AppSharedPref.removeAccessToken();
      await AppSharedPref.removeRefreshToken();
      navigatorKey.currentState?.pushReplacementNamed(RoutesName.loginPage);
    }
    return;
  }
}
