import 'package:tafaling/features/home/presentation/states/notifiers.dart';
import 'package:tafaling/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPref {
  static const localeKey = 'app_locale';
  static const themeKey = 'app_theme';
  static const authToken = 'auth_token';
  static const onboarding = 'onboarding';
  static final SharedPreferences sharedPref = serviceLoc.get();

  // Language
  static Future<void> setAppLocale(String locale) async {
    sharedPref.setString(localeKey, locale);
  }

  static Future<String> getAppLocale() async {
    return sharedPref.getString(localeKey) ?? 'en';
  }

  // Theme
  static Future<void> setAppTheme(String theme) async {
    sharedPref.setString(themeKey, theme);
  }

  static Future<String> getAppTheme() async {
    return sharedPref.getString(themeKey) ?? 'light';
  }

  // Auth
  static Future<void> setAuthToken(String token) async {
    sharedPref.setString(authToken, token);
    authNotifier.value = token;
  }

  static Future<void> removeAuthToken() async {
    sharedPref.remove(authToken);
    authNotifier.value = null;
  }

  static Future<String?> getAuthToken() async {
    return sharedPref.getString(authToken);
  }

  // Onboarding
  static Future<void> setOnboardingStatus(bool status) async {
    sharedPref.setBool(onboarding, status);
  }

  static Future<bool> getOnboardingStatus() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getBool(onboarding) ?? true;
  }

  // Clear all
  static Future<void> clearAll() async {
    sharedPref.clear();
  }
}
