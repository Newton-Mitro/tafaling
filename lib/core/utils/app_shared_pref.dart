import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPref {
  static const localeKey = 'app_locale';
  static const themeKey = 'app_theme';

  static Future<void> setAppLocale(String locale) async {
    final sharedPref = SharedPreferences.getInstance();
    sharedPref.then((pref) {
      pref.setString(localeKey, locale);
    });
  }

  static Future<String> getAppLocale() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(localeKey) ?? 'en';
  }

  static Future<void> setAppTheme(String theme) async {
    final sharedPref = SharedPreferences.getInstance();
    sharedPref.then((pref) {
      pref.setString(themeKey, theme);
    });
  }

  static Future<String> getAppTheme() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(themeKey) ?? 'light';
  }
}
