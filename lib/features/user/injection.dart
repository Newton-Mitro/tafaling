// import 'package:get_it/get_it.dart';
// import 'data/index.dart';
// import 'domain/index.dart';
// import 'presentation/index.dart';

// final sl = GetIt.instance;

// void registerUserModule() {
//   // Data Sources
//   sl.registerLazySingleton<UsersDataSource>(
//     () => UserProfileRemoteDataSourceImpl(authApiService: sl()),
//   );

//   // Repository
//   sl.registerLazySingleton<UserRepository>(
//     () => UserRepositoryImpl(sl(), sl()),
//   );

//   // Use Cases
//   sl.registerLazySingleton(() => FetchProfileUseCase(sl<UserRepository>()));
//   sl.registerLazySingleton(() => FollowUserUseCase(sl<UserRepository>()));
//   sl.registerLazySingleton(() => UnFollowUserUseCase(sl<UserRepository>()));
//   sl.registerLazySingleton(() => GetFollowersUseCase(sl<UserRepository>()));
//   sl.registerLazySingleton(
//     () => GetFollowingUsersUseCase(sl<UserRepository>()),
//   );
//   sl.registerLazySingleton(() => SearchUsersUseCase(sl<UserRepository>()));

//   // Bloc
//   sl.registerFactory(
//     () => ProfileBloc(sl<FollowUserUseCase>(), sl<UnFollowUserUseCase>()),
//   );
//   sl.registerFactory(
//     () => FollowingUsersBloc(
//       getFollowingUsersUseCase: sl<GetFollowingUsersUseCase>(),
//     ),
//   );
//   sl.registerFactory(
//     () => UserFollowersBloc(getFollowersUseCase: sl<GetFollowersUseCase>()),
//   );
// }
