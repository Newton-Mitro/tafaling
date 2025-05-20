import 'package:tafaling/core/services/local_storage/local_storage.dart';
import 'package:tafaling/core/theme/services/theme_service.dart';
import 'package:tafaling/shared/widgets/theme_selector/bloc/theme_selector_bloc.dart';

class ThemeServiceImpl implements ThemeService {
  final LocalStorage localStorage;
  static const keyTheme = 'keyTheme';

  ThemeServiceImpl(this.localStorage);

  @override
  Future<String> getTheme() async {
    final theme = await localStorage.getString(keyTheme);
    if (theme == null) {
      return ThemeName.primaryDark.themeKey;
    }
    return theme;
  }

  @override
  Future<void> setTheme(String theme) async {
    await localStorage.saveString(keyTheme, theme);
  }
}
