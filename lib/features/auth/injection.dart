import 'package:tafaling/core/injection.dart';
import 'package:tafaling/core/network/api_service.dart';
import 'package:tafaling/core/network/network_info.dart';
import 'package:tafaling/core/services/local_storage/local_storage.dart';
import 'package:tafaling/features/auth/data/data_sources/auth_data_source.dart';
import 'package:tafaling/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:tafaling/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tafaling/features/auth/domain/repositories/auth_repository.dart';
import 'package:tafaling/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:tafaling/features/auth/domain/usecases/login_usecase.dart';
import 'package:tafaling/features/auth/domain/usecases/logout_usecase.dart';
import 'package:tafaling/features/auth/domain/usecases/registration_usecase.dart';
import 'package:tafaling/features/auth/presentation/views/login_screen/bloc/login_screen_bloc.dart';
import 'package:tafaling/features/auth/presentation/views/registration_screen/bloc/registration_screen_bloc.dart';
import 'presentation/index.dart';

void registerAuthModule() {
  // Register Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      apiService: sl<ApiService>(),
      localStorage: sl<LocalStorage>(),
    ),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(localStorage: sl<LocalStorage>()),
  );

  // Register Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: sl<AuthRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>(),
      authLocalDataSource: sl<AuthLocalDataSource>(),
    ),
  );

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
  sl.registerLazySingleton<GetAuthUserUseCase>(
    () => GetAuthUserUseCase(authRepository: sl<AuthRepository>()),
  );

  // Register Bloc
  sl.registerFactory<LoginScreenBloc>(
    () => LoginScreenBloc(loginUseCase: sl<LoginUseCase>()),
  );

  sl.registerFactory<RegistrationScreenBloc>(
    () =>
        RegistrationScreenBloc(registrationUseCase: sl<RegistrationUseCase>()),
  );

  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      logoutUseCase: sl<LogoutUsecase>(),
      getAuthUserUseCase: sl<GetAuthUserUseCase>(),
    ),
  );
}
