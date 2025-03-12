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
import 'package:tafaling/features/auth/presentation/states/login_bloc/login_screen_bloc.dart';
import 'package:tafaling/features/auth/presentation/states/register_bloc/signup_screen_bloc.dart';
import 'package:tafaling/features/home/presentation/states/bloc/home_screen_bloc.dart';
import 'package:tafaling/features/post/data/data_sources/post_remote_data_source.dart';
import 'package:tafaling/features/post/data/repositories/post_repository_impl.dart';
import 'package:tafaling/features/post/domain/repositories/post_repository.dart';
import 'package:tafaling/features/post/domain/usecases/dis_like_post_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/fetch_posts_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/fetch_user_posts_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/like_post_usecase.dart';
import 'package:tafaling/features/post/presentation/states/post_bloc/posts_screen_bloc.dart';
import 'package:tafaling/features/user/data/data_sources/user_profile_remote_data_source.dart';
import 'package:tafaling/features/user/data/repositories/user_profile_repository_impl.dart';
import 'package:tafaling/features/user/domain/repositories/user_profile_repository.dart';
import 'package:tafaling/features/user/domain/usecases/fetch_profile_usecase.dart';
import 'package:tafaling/features/user/domain/usecases/follow_user_usecase.dart';
import 'package:tafaling/features/user/domain/usecases/search_users_usecase.dart';
import 'package:tafaling/features/user/domain/usecases/un_follow_user_usecase.dart';
import 'package:tafaling/features/user/presentation/states/profile_bloc/profile_bloc.dart';
import 'package:tafaling/features/user/presentation/states/user_search_bloc/search_screen_bloc.dart';

var servLoc = GetIt.instance;

Future<void> getInit() async {
  await _setupComponents();
  await _setupDatasources();
  await _setupRepositories();
  await _setupUsecases();
  await _setupStates();
}

Future<void> _setupComponents() async {
  // Register your services here
  servLoc.registerLazySingleton<Dio>(() => Dio());
  servLoc.registerLazySingleton<NetworkService>(() => NetworkService());

  servLoc.registerLazySingleton<ApiService>(() => ApiService());
  servLoc.registerLazySingleton<AuthApiService>(() => AuthApiService());

  servLoc.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
}

Future<void> _setupDatasources() async {
  servLoc.registerLazySingleton<AuthRemoteDataSource>(() =>
      AuthRemoteDataSourceImpl(
          apiService: servLoc(), authApiService: servLoc()));
  servLoc.registerLazySingleton<PostRemoteDataSource>(() =>
      PostRemoteDataSourceImpl(
          apiService: servLoc(), authApiService: servLoc()));
  servLoc.registerLazySingleton<UserProfileRemoteDataSource>(
      () => UserProfileRemoteDataSourceImpl(authApiService: servLoc()));
}

Future<void> _setupRepositories() async {
  servLoc.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(servLoc(), servLoc()));
  servLoc.registerLazySingleton<PostRepository>(
      () => PostRepositoryImpl(servLoc(), servLoc()));
  servLoc.registerLazySingleton<UserProfileRepository>(
      () => UserProfileRepositoryImpl(servLoc(), servLoc()));
}

Future<void> _setupUsecases() async {
  servLoc.registerLazySingleton(() => LoginUseCase(servLoc<AuthRepository>()));
  servLoc
      .registerLazySingleton(() => RegisterUseCase(servLoc<AuthRepository>()));
  servLoc.registerLazySingleton(
      () => FetchPostsUseCase(servLoc<PostRepository>()));
  servLoc
      .registerLazySingleton(() => LikePostUseCase(servLoc<PostRepository>()));
  servLoc.registerLazySingleton(
      () => FetchUserPostsUseCase(servLoc<PostRepository>()));
  servLoc.registerLazySingleton(
      () => DisLikePostUseCase(servLoc<PostRepository>()));
  servLoc.registerLazySingleton(
      () => SearchUsersUseCase(servLoc<UserProfileRepository>()));
  servLoc.registerLazySingleton(
      () => FetchProfileUseCase(servLoc<UserProfileRepository>()));
  servLoc.registerLazySingleton(
      () => FollowUserUseCase(servLoc<UserProfileRepository>()));
  servLoc.registerLazySingleton(
      () => UnFollowUserUseCase(servLoc<UserProfileRepository>()));
}

Future<void> _setupStates() async {
  servLoc.registerFactory(() => LoginScreenBloc(servLoc<LoginUseCase>()));
  servLoc.registerFactory(() => SignUpScreenBloc(servLoc<RegisterUseCase>()));
  servLoc.registerFactory(() => HomeScreenBloc());
  servLoc.registerFactory(() => SearchScreenBloc(servLoc<SearchUsersUseCase>(),
      servLoc<FollowUserUseCase>(), servLoc<UnFollowUserUseCase>()));
  servLoc.registerFactory(() => PostsScreenBloc(
      servLoc<FetchPostsUseCase>(),
      servLoc<FetchUserPostsUseCase>(),
      servLoc<LikePostUseCase>(),
      servLoc<DisLikePostUseCase>()));
  servLoc.registerFactory(() => ProfileBloc(servLoc<FetchProfileUseCase>()));
}
