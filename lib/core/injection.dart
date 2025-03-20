import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'network/api_service.dart';
import 'network/auth_api_service.dart';
import 'network/network_info.dart';

final sl = GetIt.instance;

Future<void> registerCoreServices() async {
  // Third-party services
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );

  // Core Services
  sl.registerLazySingleton<NetworkService>(() => NetworkService());
  sl.registerLazySingleton<ApiService>(() => ApiService());
  sl.registerLazySingleton<AuthApiService>(() => AuthApiService());
}
