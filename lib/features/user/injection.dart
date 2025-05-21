import 'package:tafaling/core/injection.dart';
import 'package:tafaling/core/network/api_service.dart';
import 'package:tafaling/core/network/network_info.dart';
import 'package:tafaling/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:tafaling/features/user/data/data_sources/user_data_source.dart';
import 'package:tafaling/features/user/data/data_sources/users_remote_data_source.dart';
import 'package:tafaling/features/user/data/repositories/user_repository_impl.dart';
import 'package:tafaling/features/user/domain/repositories/user_profile_repository.dart';
import 'package:tafaling/features/user/domain/usecases/fetch_profile_usecase.dart';
import 'package:tafaling/features/user/domain/usecases/follow_user_usecase.dart';
import 'package:tafaling/features/user/domain/usecases/get_followers_usecase.dart';
import 'package:tafaling/features/user/domain/usecases/get_following_users_usecase.dart';
import 'package:tafaling/features/user/domain/usecases/get_suggested_users_usecase.dart';
import 'package:tafaling/features/user/domain/usecases/search_users_usecase.dart';
import 'package:tafaling/features/user/domain/usecases/un_follow_user_usecase.dart';
import 'package:tafaling/features/user/presentation/following_users_screen/bloc/following_users_bloc.dart';
import 'package:tafaling/features/user/presentation/friends_screen/bloc/friends_bloc.dart';
import 'package:tafaling/features/user/presentation/my_profile_screen/bloc/my_profile_bloc.dart';
import 'package:tafaling/features/user/presentation/search_screen/bloc/search_screen_bloc.dart';
import 'package:tafaling/features/user/presentation/user_profile_screen/bloc/profile_bloc.dart';
import 'package:tafaling/features/user/presentation/users_followers_screen/bloc/users_followers_bloc.dart';
import 'package:tafaling/features/user/presentation/widgets/user_tile/bloc/user_tile_bloc.dart';

void registerUserModule() {
  // Data Sources
  sl.registerLazySingleton<UsersDataSource>(
    () => UserProfileRemoteDataSourceImpl(authApiService: sl<ApiService>()),
  );

  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: sl<UsersDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(
    () => FetchProfileUseCase(userRepository: sl<UserRepository>()),
  );
  sl.registerLazySingleton(
    () => FollowUserUseCase(userRepository: sl<UserRepository>()),
  );
  sl.registerLazySingleton(
    () => UnFollowUserUseCase(userRepository: sl<UserRepository>()),
  );
  sl.registerLazySingleton(
    () => GetFollowersUseCase(userRepository: sl<UserRepository>()),
  );
  sl.registerLazySingleton(
    () => GetFollowingUsersUseCase(userRepository: sl<UserRepository>()),
  );
  sl.registerLazySingleton(
    () => SearchUsersUseCase(userRepository: sl<UserRepository>()),
  );
  sl.registerLazySingleton(
    () => GetSuggestedUsersUseCase(userRepository: sl<UserRepository>()),
  );

  // Bloc
  sl.registerFactory(
    () => ProfileBloc(
      followUserUseCase: sl<FollowUserUseCase>(),
      unFollowUserUseCase: sl<UnFollowUserUseCase>(),
    ),
  );

  sl.registerFactory(
    () => MyProfileBloc(
      followUserUseCase: sl<FollowUserUseCase>(),
      unFollowUserUseCase: sl<UnFollowUserUseCase>(),
      getAuthUserUseCase: sl<GetAuthUserUseCase>(),
    ),
  );
  sl.registerFactory(
    () => FollowingUsersBloc(
      getFollowingUsersUseCase: sl<GetFollowingUsersUseCase>(),
    ),
  );
  sl.registerFactory(
    () => UserFollowersBloc(getFollowersUseCase: sl<GetFollowersUseCase>()),
  );

  sl.registerFactory(
    () => SearchScreenBloc(searchUsersUseCase: sl<SearchUsersUseCase>()),
  );

  sl.registerFactory(
    () => UserTileBloc(
      followUserUseCase: sl<FollowUserUseCase>(),
      unFollowUserUseCase: sl<UnFollowUserUseCase>(),
    ),
  );

  sl.registerFactory(
    () => FriendsBloc(getSuggestedUsersUseCase: sl<GetSuggestedUsersUseCase>()),
  );
}
