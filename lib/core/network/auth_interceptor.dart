import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class XAuthInterceptor extends Interceptor {
  Dio dio;
  XAuthInterceptor({required this.dio});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Check if this request should skip authentication
    if (options.extra["ignoreAuth"] == true) {
      return handler.next(options);
    }

    final prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString("access_token");

    // If token exists, check expiration
    if (accessToken != null) {
      if (_isTokenExpired(accessToken)) {
        accessToken = await _refreshToken();
      }
      if (accessToken != null) {
        options.headers["Authorization"] = "Bearer $accessToken";
      }
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final newToken = await _refreshToken();
      if (newToken != null) {
        err.requestOptions.headers["Authorization"] = "Bearer $newToken";
        final opts = Options(
          method: err.requestOptions.method,
          headers: err.requestOptions.headers,
        );

        try {
          final response = await dio.request(
            err.requestOptions.path,
            options: opts,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
          );
          return handler.resolve(response);
        } catch (e) {
          return handler.reject(err);
        }
      }
    }
    return handler.next(err);
  }

  bool _isTokenExpired(String token) {
    return JwtDecoder.isExpired(token);
  }

  Future<String?> _refreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? refreshToken = prefs.getString("refresh_token");

    if (refreshToken == null) return null;

    try {
      final response = await dio
          .post("/auth/refresh", data: {"refresh_token": refreshToken});
      if (response.statusCode == 200) {
        String newAccessToken = response.data["access_token"];
        await prefs.setString("access_token", newAccessToken);
        return newAccessToken;
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
