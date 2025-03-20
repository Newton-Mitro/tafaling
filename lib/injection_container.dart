import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tafaling/core/network/api_service.dart';
import 'package:tafaling/core/network/auth_api_service.dart';
import 'package:tafaling/core/network/network_info.dart';
import 'package:tafaling/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:tafaling/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tafaling/features/auth/domain/repositories/auth_repository.dart';
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
import 'package:tafaling/features/post/domain/usecases/get_post_liked_users_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/like_post_usecase.dart';
import 'package:tafaling/features/post/presentation/views/post_liked_users_screen/bloc/post_liked_users_bloc.dart';
import 'package:tafaling/features/post/presentation/views/posts_screen/bloc/posts_screen_bloc.dart';
import 'package:tafaling/features/user/data/data_sources/user_data_source.dart';
import 'package:tafaling/features/user/data/data_sources/users_remote_data_source.dart';
import 'package:tafaling/features/user/data/repositories/user_repository_impl.dart';
import 'package:tafaling/features/user/domain/repositories/user_profile_repository.dart';
import 'package:tafaling/features/user/domain/usecases/fetch_profile_usecase.dart';
import 'package:tafaling/features/user/domain/usecases/follow_user_usecase.dart';
import 'package:tafaling/features/user/domain/usecases/get_followers_usecase.dart';
import 'package:tafaling/features/user/domain/usecases/get_following_users_usecase.dart';
import 'package:tafaling/features/user/domain/usecases/search_users_usecase.dart';
import 'package:tafaling/features/user/domain/usecases/un_follow_user_usecase.dart';
import 'package:tafaling/features/user/presentation/following_users_screen/bloc/following_users_bloc.dart';
import 'package:tafaling/features/user/presentation/user_profile_screen/bloc/profile_bloc.dart';
import 'package:tafaling/features/user/presentation/search_screen/bloc/search_screen_bloc.dart';
import 'package:tafaling/features/user/presentation/users_followers_screen/bloc/users_followers_bloc.dart';
import 'package:tafaling/features/user/presentation/widgets/user_tile/bloc/user_tile_bloc.dart';

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
    await SharedPreferences.getInstance(),
  );
}

Future<void> _setupDatasources() async {
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiService: sl(), authApiService: sl()),
  );
  sl.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSourceImpl(apiService: sl(), authApiService: sl()),
  );
  sl.registerLazySingleton<UsersDataSource>(
    () => UserProfileRemoteDataSourceImpl(authApiService: sl()),
  );
}

Future<void> _setupRepositories() async {
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(sl(), sl()),
  );
}

Future<void> _setupUsecases() async {
  sl.registerLazySingleton(() => LoginUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => RegistrationUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => LogoutUsecase(sl<AuthRepository>()));

  sl.registerLazySingleton(() => FetchPostsUseCase(sl<PostRepository>()));
  sl.registerLazySingleton(() => LikePostUseCase(sl<PostRepository>()));
  sl.registerLazySingleton(() => FetchUserPostsUseCase(sl<PostRepository>()));
  sl.registerLazySingleton(() => DisLikePostUseCase(sl<PostRepository>()));

  sl.registerLazySingleton(
    () => GetPostLikedUsersUsecase(sl<PostRepository>()),
  );
  sl.registerLazySingleton(
    () => GetFollowingUsersUseCase(sl<UserRepository>()),
  );
  sl.registerLazySingleton(() => SearchUsersUseCase(sl<UserRepository>()));
  sl.registerLazySingleton(() => FetchProfileUseCase(sl<UserRepository>()));
  sl.registerLazySingleton(() => FollowUserUseCase(sl<UserRepository>()));
  sl.registerLazySingleton(() => UnFollowUserUseCase(sl<UserRepository>()));
  sl.registerLazySingleton(() => GetFollowersUseCase(sl<UserRepository>()));
}

Future<void> _setupStates() async {
  sl.registerCachedFactory(
    () => AuthBloc(
      registrationUseCase: sl<RegistrationUseCase>(),
      loginUseCase: sl<LoginUseCase>(),
      logoutUseCase: sl<LogoutUsecase>(),
    ),
  );
  sl.registerFactory(
    () => SearchScreenBloc(
      sl<SearchUsersUseCase>(),
      sl<FollowUserUseCase>(),
      sl<UnFollowUserUseCase>(),
    ),
  );
  sl.registerFactory(
    () => PostsScreenBloc(
      sl<FetchPostsUseCase>(),
      sl<FetchUserPostsUseCase>(),
      sl<LikePostUseCase>(),
      sl<DisLikePostUseCase>(),
    ),
  );
  sl.registerFactory(
    () => ProfileBloc(
      // sl<FetchProfileUseCase>(),
      sl<FollowUserUseCase>(),
      sl<UnFollowUserUseCase>(),
    ),
  );

  sl.registerFactory(
    () => UserFollowersBloc(getFollowersUseCase: sl<GetFollowersUseCase>()),
  );

  sl.registerFactory(
    () => FollowingUsersBloc(
      getFollowingUsersUseCase: sl<GetFollowingUsersUseCase>(),
    ),
  );

  sl.registerFactory(
    () => PostLikedUsersBloc(
      getPostLikedUsersUsecase: sl<GetPostLikedUsersUsecase>(),
    ),
  );

  sl.registerFactory(
    () => UserTileBloc(sl<FollowUserUseCase>(), sl<UnFollowUserUseCase>()),
  );
}
