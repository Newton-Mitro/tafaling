import 'package:tafaling/core/locale/services/locale_service.dart';
import 'package:tafaling/core/services/local_storage/local_storage.dart';

class LocaleServiceImpl implements LocaleService {
  static const keyLocale = 'keyLocale';
  final LocalStorage localStorage;

  LocaleServiceImpl(this.localStorage);

  @override
  Future<String> getLocale() async {
    final locale = await localStorage.getString(keyLocale);
    if (locale == null) {
      return 'en';
    }
    return locale;
  }

  @override
  Future<void> setLocale(String locale) async {
    await localStorage.saveString(keyLocale, locale);
  }
}
