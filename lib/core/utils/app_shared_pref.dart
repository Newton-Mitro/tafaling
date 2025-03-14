import 'dart:convert';

import 'package:tafaling/features/home/presentation/notifier/notifiers.dart';
import 'package:tafaling/features/user/data/models/user_model.dart';
import 'package:tafaling/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPref {
  static const _localeKey = 'app_locale';
  static const _themeKey = 'app_theme';
  static const _authUser = 'auth_user';
  static const _accessToken = 'access_token';
  static const _refreshToken = 'refresh_token';
  static const _onboarding = 'onboarding';
  static final SharedPreferences sharedPref = serviceLoc.get();

  // Language
  static Future<void> setAppLocale(String locale) async {
    sharedPref.setString(_localeKey, locale);
  }

  static Future<String> getAppLocale() async {
    return sharedPref.getString(_localeKey) ?? 'en';
  }

  // Theme
  static Future<void> setAppTheme(String theme) async {
    sharedPref.setString(_themeKey, theme);
  }

  static Future<String> getAppTheme() async {
    return sharedPref.getString(_themeKey) ?? 'light';
  }

  // Auth User
  static Future<void> setAuthUser(UserModel authUser) async {
    sharedPref.setString(_authUser, jsonEncode(authUser));
    authUserNotifier.value = authUser;
  }

  static Future<void> removeAuthUser() async {
    sharedPref.remove(_authUser);
    authUserNotifier.value = null;
  }

  static Future<UserModel?> getAuthUser() async {
    var authUser = sharedPref.getString(_authUser);
    if (authUser != null) {
      return UserModel.fromJson(jsonDecode(authUser));
    }
    return null;
  }

  // Access Token
  static Future<void> setAccessToken(String accessToken) async {
    sharedPref.setString(_accessToken, accessToken);
    accessTokenNotifier.value = accessToken;
    selectedPostNotifier.value = 0;
  }

  static Future<String?> getAccessToken() async {
    return sharedPref.getString(_accessToken);
  }

  static Future<void> removeAccessToken() async {
    sharedPref.remove(_accessToken);
    accessTokenNotifier.value = null;
    selectedPostNotifier.value = 0;
  }

  // Refresh Token
  static Future<void> setRefreshToken(String refreshToken) async {
    sharedPref.setString(_refreshToken, refreshToken);
  }

  static Future<String?> getRefreshToken() async {
    return sharedPref.getString(_refreshToken);
  }

  static Future<void> removeRefreshToken() async {
    sharedPref.remove(_refreshToken);
  }

  // Onboarding
  static Future<void> setOnboardingStatus(bool status) async {
    sharedPref.setBool(_onboarding, status);
  }

  static Future<bool> getOnboardingStatus() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getBool(_onboarding) ?? true;
  }

  // Clear all
  static Future<void> clearAll() async {
    sharedPref.clear();
  }
}
