import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:tafaling/core/locale/services/locale_service.dart';
import 'package:tafaling/core/locale/services/locale_service_impl.dart';
import 'package:tafaling/core/services/local_storage/local_storage.dart';
import 'package:tafaling/core/services/local_storage/local_storage_impl.dart';
import 'package:tafaling/core/services/logging/logger_service.dart';
import 'package:tafaling/core/services/logging/logger_service_impl.dart';
import 'package:tafaling/core/network/network_info.dart';
import 'package:tafaling/core/network/network_info_impl.dart';
import 'package:tafaling/core/theme/services/theme_service.dart';
import 'package:tafaling/core/theme/services/theme_service_impl.dart';
import 'package:tafaling/features/auth/data/data_sources/auth_data_source.dart';
import 'package:tafaling/shared/widgets/language_switch/bloc/language_switch_bloc.dart';
import 'package:tafaling/shared/widgets/theme_selector/bloc/theme_selector_bloc.dart';
import 'network/api_service.dart';

final sl = GetIt.instance;

Future<void> registerCoreServices() async {
  // ✅ Logging Service
  sl.registerLazySingleton<LoggerService>(() => LoggerServiceImpl());

  // ✅ Network Info (Detects Internet Connectivity)
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectivity: sl<Connectivity>()),
  );

  sl.registerLazySingleton<LocalStorage>(() => LocalStorageImpl());
  sl.registerLazySingleton<ApiService>(
    () => ApiService(
      authLocalDataSource: sl<AuthLocalDataSource>(),
      loggerService: sl<LoggerService>(),
    ),
  );
  sl.registerLazySingleton<LocaleService>(
    () => LocaleServiceImpl(sl<LocalStorage>()),
  );
  sl.registerLazySingleton<ThemeService>(
    () => ThemeServiceImpl(sl<LocalStorage>()),
  );

  // Register Bloc

  // Register Bloc
  sl.registerFactory<LanguageSwitchBloc>(
    () => LanguageSwitchBloc(localeService: sl<LocaleService>()),
  );

  sl.registerFactory<ThemeSelectorBloc>(
    () => ThemeSelectorBloc(themeService: sl<ThemeService>()),
  );
}
