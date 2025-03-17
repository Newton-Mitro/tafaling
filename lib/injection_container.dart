import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tafaling/core/network/api_service.dart';
import 'package:tafaling/core/network/auth_api_service.dart';
import 'package:tafaling/core/network/network_info.dart';
import 'package:tafaling/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:tafaling/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tafaling/features/auth/domain/repositories/auth_repository.dart';
import 'package:tafaling/features/auth/domain/usecases/auth_user_usecase.dart';
import 'package:tafaling/features/auth/domain/usecases/is_logged_in_usecase.dart';
import 'package:tafaling/features/auth/domain/usecases/login_usecase.dart';
import 'package:tafaling/features/auth/domain/usecases/logout_usecase.dart';
import 'package:tafaling/features/auth/domain/usecases/registration_usecase.dart';
import 'package:tafaling/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:tafaling/features/post/data/data_sources/post_remote_data_source.dart';
import 'package:tafaling/features/post/data/repositories/post_repository_impl.dart';
import 'package:tafaling/features/post/domain/repositories/post_repository.dart';
import 'package:tafaling/features/post/domain/usecases/dis_like_post_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/fetch_posts_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/fetch_user_posts_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/like_post_usecase.dart';
import 'package:tafaling/features/post/presentation/posts_screen/bloc/posts_screen_bloc.dart';
import 'package:tafaling/features/user/data/data_sources/user_profile_remote_data_source.dart';
import 'package:tafaling/features/user/data/repositories/user_profile_repository_impl.dart';
import 'package:tafaling/features/user/domain/repositories/user_profile_repository.dart';
import 'package:tafaling/features/user/domain/usecases/fetch_profile_usecase.dart';
import 'package:tafaling/features/user/domain/usecases/follow_user_usecase.dart';
import 'package:tafaling/features/user/domain/usecases/search_users_usecase.dart';
import 'package:tafaling/features/user/domain/usecases/un_follow_user_usecase.dart';
import 'package:tafaling/features/user/presentation/user_profile_screen/bloc/profile_bloc.dart';
import 'package:tafaling/features/user/presentation/search_screen/bloc/search_screen_bloc.dart';

var sl = GetIt.instance;

Future<void> getInit() async {
  await _setupComponents();
  await _setupDatasources();
  await _setupRepositories();
  await _setupUsecases();
  await _setupStates();
}

Future<void> _setupComponents() async {
  // Register your services here
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<NetworkService>(() => NetworkService());

  sl.registerLazySingleton<ApiService>(() => ApiService());
  sl.registerLazySingleton<AuthApiService>(() => AuthApiService());

  sl.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
}

Future<void> _setupDatasources() async {
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(apiService: sl(), authApiService: sl()));
  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(apiService: sl(), authApiService: sl()));
  sl.registerLazySingleton<UserProfileRemoteDataSource>(
      () => UserProfileRemoteDataSourceImpl(authApiService: sl()));
}

Future<void> _setupRepositories() async {
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<PostRepository>(
      () => PostRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<UserProfileRepository>(
      () => UserProfileRepositoryImpl(sl(), sl()));
}

Future<void> _setupUsecases() async {
  sl.registerLazySingleton(() => LoginUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => RegistrationUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => LogoutUsecase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => IsLoggedInUsecase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => AuthUserUsecase(sl<AuthRepository>()));

  sl.registerLazySingleton(() => FetchPostsUseCase(sl<PostRepository>()));
  sl.registerLazySingleton(() => LikePostUseCase(sl<PostRepository>()));
  sl.registerLazySingleton(() => FetchUserPostsUseCase(sl<PostRepository>()));
  sl.registerLazySingleton(() => DisLikePostUseCase(sl<PostRepository>()));
  sl.registerLazySingleton(
      () => SearchUsersUseCase(sl<UserProfileRepository>()));
  sl.registerLazySingleton(
      () => FetchProfileUseCase(sl<UserProfileRepository>()));
  sl.registerLazySingleton(
      () => FollowUserUseCase(sl<UserProfileRepository>()));
  sl.registerLazySingleton(
      () => UnFollowUserUseCase(sl<UserProfileRepository>()));
}

Future<void> _setupStates() async {
  sl.registerCachedFactory(
    () => AuthBloc(
      registrationUseCase: sl<RegistrationUseCase>(),
      loginUseCase: sl<LoginUseCase>(),
      logoutUseCase: sl<LogoutUsecase>(),
      isLoggedInUseCase: sl<IsLoggedInUsecase>(),
      authUserUsecase: sl<AuthUserUsecase>(),
    ),
  );

  sl.registerFactory(() => SearchScreenBloc(sl<SearchUsersUseCase>(),
      sl<FollowUserUseCase>(), sl<UnFollowUserUseCase>()));
  sl.registerFactory(() => PostsScreenBloc(
      sl<FetchPostsUseCase>(),
      sl<FetchUserPostsUseCase>(),
      sl<LikePostUseCase>(),
      sl<DisLikePostUseCase>()));
  sl.registerFactory(() => ProfileBloc(
        sl<FetchProfileUseCase>(),
        sl<FollowUserUseCase>(),
        sl<UnFollowUserUseCase>(),
      ));
}
