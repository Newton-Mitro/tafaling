import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tafaling/core/network_old/api_service.dart';
import 'package:tafaling/core/network_old/auth_api_service.dart';
import 'package:tafaling/core/network_old/network_info.dart';
import 'package:tafaling/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:tafaling/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tafaling/features/auth/domain/repositories/auth_repository.dart';
import 'package:tafaling/features/auth/domain/usecases/login_usecase.dart';
import 'package:tafaling/features/auth/domain/usecases/signup_usecase.dart';
import 'package:tafaling/features/auth/presentation/login_screen/bloc/login_screen_bloc.dart';
import 'package:tafaling/features/auth/presentation/registration_screen/bloc/signup_screen_bloc.dart';
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

var serviceLoc = GetIt.instance;

Future<void> getInit() async {
  await _setupComponents();
  await _setupDatasources();
  await _setupRepositories();
  await _setupUsecases();
  await _setupStates();
}

Future<void> _setupComponents() async {
  // Register your services here
  serviceLoc.registerLazySingleton<Dio>(() => Dio());
  serviceLoc.registerLazySingleton<NetworkService>(() => NetworkService());

  serviceLoc.registerLazySingleton<ApiService>(() => ApiService());
  serviceLoc.registerLazySingleton<AuthApiService>(() => AuthApiService());

  serviceLoc.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
}

Future<void> _setupDatasources() async {
  serviceLoc.registerLazySingleton<AuthRemoteDataSource>(() =>
      AuthRemoteDataSourceImpl(
          apiService: serviceLoc(), authApiService: serviceLoc()));
  serviceLoc.registerLazySingleton<PostRemoteDataSource>(() =>
      PostRemoteDataSourceImpl(
          apiService: serviceLoc(), authApiService: serviceLoc()));
  serviceLoc.registerLazySingleton<UserProfileRemoteDataSource>(
      () => UserProfileRemoteDataSourceImpl(authApiService: serviceLoc()));
}

Future<void> _setupRepositories() async {
  serviceLoc.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(serviceLoc(), serviceLoc()));
  serviceLoc.registerLazySingleton<PostRepository>(
      () => PostRepositoryImpl(serviceLoc(), serviceLoc()));
  serviceLoc.registerLazySingleton<UserProfileRepository>(
      () => UserProfileRepositoryImpl(serviceLoc(), serviceLoc()));
}

Future<void> _setupUsecases() async {
  serviceLoc
      .registerLazySingleton(() => LoginUseCase(serviceLoc<AuthRepository>()));
  serviceLoc.registerLazySingleton(
      () => RegisterUseCase(serviceLoc<AuthRepository>()));
  serviceLoc.registerLazySingleton(
      () => FetchPostsUseCase(serviceLoc<PostRepository>()));
  serviceLoc.registerLazySingleton(
      () => LikePostUseCase(serviceLoc<PostRepository>()));
  serviceLoc.registerLazySingleton(
      () => FetchUserPostsUseCase(serviceLoc<PostRepository>()));
  serviceLoc.registerLazySingleton(
      () => DisLikePostUseCase(serviceLoc<PostRepository>()));
  serviceLoc.registerLazySingleton(
      () => SearchUsersUseCase(serviceLoc<UserProfileRepository>()));
  serviceLoc.registerLazySingleton(
      () => FetchProfileUseCase(serviceLoc<UserProfileRepository>()));
  serviceLoc.registerLazySingleton(
      () => FollowUserUseCase(serviceLoc<UserProfileRepository>()));
  serviceLoc.registerLazySingleton(
      () => UnFollowUserUseCase(serviceLoc<UserProfileRepository>()));
}

Future<void> _setupStates() async {
  serviceLoc.registerFactory(() => LoginScreenBloc(serviceLoc<LoginUseCase>()));
  serviceLoc
      .registerFactory(() => SignUpScreenBloc(serviceLoc<RegisterUseCase>()));
  serviceLoc.registerFactory(() => SearchScreenBloc(
      serviceLoc<SearchUsersUseCase>(),
      serviceLoc<FollowUserUseCase>(),
      serviceLoc<UnFollowUserUseCase>()));
  serviceLoc.registerFactory(() => PostsScreenBloc(
      serviceLoc<FetchPostsUseCase>(),
      serviceLoc<FetchUserPostsUseCase>(),
      serviceLoc<LikePostUseCase>(),
      serviceLoc<DisLikePostUseCase>()));
  serviceLoc.registerFactory(() => ProfileBloc(
        serviceLoc<FetchProfileUseCase>(),
        serviceLoc<FollowUserUseCase>(),
        serviceLoc<UnFollowUserUseCase>(),
      ));
}
