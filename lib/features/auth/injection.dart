// import 'package:get_it/get_it.dart';
// import 'data/index.dart'; // Import barrel files
// import 'domain/index.dart';
// import 'presentation/index.dart';

// final sl = GetIt.instance;

// void registerAuthModule() {
//   // Data Sources
//   sl.registerLazySingleton<AuthRemoteDataSource>(
//     () => AuthRemoteDataSourceImpl(apiService: sl(), authApiService: sl()),
//   );

//   // Repository
//   sl.registerLazySingleton<AuthRepository>(
//     () => AuthRepositoryImpl(sl(), sl()),
//   );

//   // Use Cases
//   sl.registerLazySingleton(() => LoginUseCase(sl<AuthRepository>()));
//   sl.registerLazySingleton(() => RegistrationUseCase(sl<AuthRepository>()));
//   sl.registerLazySingleton(() => LogoutUseCase(sl<AuthRepository>()));

//   // Bloc
//   sl.registerFactory(
//     () => AuthBloc(
//       registrationUseCase: sl(),
//       loginUseCase: sl(),
//       logoutUseCase: sl(),
//     ),
//   );
// }
