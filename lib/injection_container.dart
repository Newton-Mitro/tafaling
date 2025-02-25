import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.instance;

Future<void> getInit() async {
  await _setupComponents();
  await _setupDatasources();
  await _setupRepositories();
}

Future<void> _setupComponents() async {
  // Register your services here
  // locator.registerLazySingleton(() => DioProvider.createDioWithHeader());
  // locator.registerLazySingleton(() => AuthManager());
  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
}

Future<void> _setupDatasources() async {
  // locator.registerFactory(<IAuthDatasource>() => AuthRemoteDatasource());
}

Future<void> _setupRepositories() async {}
