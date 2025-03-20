import 'package:get_it/get_it.dart';
import 'package:tafaling/core/index.dart';
import 'data/index.dart';
import 'domain/index.dart';
import 'presentation/index.dart';

final sl = GetIt.instance;

void registerAuthModule() {
  // Register Data Sources
  sl.registerLazySingleton<AuthDataSource>(
    () => AuthRemoteDataSourceImpl(
      apiService: sl<ApiService>(),
      authApiService: sl<AuthApiService>(),
    ),
  );

  // Register Repository
  // sl.registerLazySingleton<AuthRepository>(
  //   () => AuthRepositoryImpl(
  //     remoteDataSource: sl<AuthDataSource>(),
  //     networkService: sl<NetworkService>(),
  //   ),
  // );

  // Register Use Cases
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(authRepository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<RegistrationUseCase>(
    () => RegistrationUseCase(authRepository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<LogoutUsecase>(
    () => LogoutUsecase(authRepository: sl<AuthRepository>()),
  );

  // Register Bloc
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      registrationUseCase: sl<RegistrationUseCase>(),
      loginUseCase: sl<LoginUseCase>(),
      logoutUseCase: sl<LogoutUsecase>(),
    ),
  );
}
