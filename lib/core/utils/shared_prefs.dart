import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<void> saveAccessToken(String accessToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
  }

  static Future<void> saveRefreshToken(String refreshToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('refresh_token', refreshToken);
  }

  static Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  static Future<String?> getRefreshToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('refresh_token');
  }

  static Future<void> saveUserId(int userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId);
  }

  static Future<int?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  static Future<void> saveUser(String user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', user);
  }

  static Future<String?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user');
  }

  static Future<void> clearTokens() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
  }
}
