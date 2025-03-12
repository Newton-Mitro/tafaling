import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:tafaling/configs/routes/route_name.dart';
import 'package:tafaling/core/utils/shared_prefs.dart';
import 'package:tafaling/main.dart';
import 'package:tafaling/my_app.dart';

class AuthInterceptor extends Interceptor {
  String? accessToken;
  String? refreshToken;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Retrieve tokens
    await _retrieveTokens();
    options.headers['Accept'] = 'application/json';
    options.validateStatus = (status) {
      return status! < 600; // Accepts all status codes below 500
    };

    bool isTokenValid = _isAccessTokenValid();

    if (isTokenValid) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    } else {
      await SharedPrefs.clearTokens();
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

  Future<void> _retrieveTokens() async {
    accessToken = await SharedPrefs.getAccessToken();
    refreshToken = await SharedPrefs.getRefreshToken();
  }

  bool _isAccessTokenValid() {
    return accessToken != null && !JwtDecoder.isExpired(accessToken!);
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

        final at = data['access_token'];
        final rt = data['refresh_token'];
        if (accessToken != null && refreshToken != null) {
          await SharedPrefs.saveAccessToken(at!);
          await SharedPrefs.saveRefreshToken(rt!);
        }

        // Retry the original request with the new access token
        options.headers['Authorization'] = 'Bearer $at';
        final retryResponse = await Dio().fetch(options);
        handler.resolve(retryResponse);
      } else {
        await SharedPrefs.clearTokens();
        navigatorKey.currentState?.pushReplacementNamed(RoutesName.loginPage);
        handler
            .reject(DioException(requestOptions: options, response: response));
      }
    } on DioException {
      await SharedPrefs.clearTokens();
      navigatorKey.currentState?.pushReplacementNamed(RoutesName.loginPage);
    }
    return;
  }
}
