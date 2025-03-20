// import 'package:get_it/get_it.dart';
// import 'data/index.dart';
// import 'domain/index.dart';
// import 'presentation/index.dart';

// final sl = GetIt.instance;

// void registerPostModule() {
//   // Data Sources
//   sl.registerLazySingleton<PostRemoteDataSource>(
//     () => PostRemoteDataSourceImpl(apiService: sl(), authApiService: sl()),
//   );

//   // Repository
//   sl.registerLazySingleton<PostRepository>(
//     () => PostRepositoryImpl(sl(), sl()),
//   );

//   // Use Cases
//   sl.registerLazySingleton(() => FetchPostsUseCase(sl<PostRepository>()));
//   sl.registerLazySingleton(() => LikePostUseCase(sl<PostRepository>()));
//   sl.registerLazySingleton(() => FetchUserPostsUseCase(sl<PostRepository>()));
//   sl.registerLazySingleton(() => DisLikePostUseCase(sl<PostRepository>()));
//   sl.registerLazySingleton(
//     () => GetPostLikedUsersUsecase(sl<PostRepository>()),
//   );

//   // Bloc
//   sl.registerFactory(
//     () => PostsScreenBloc(
//       sl<FetchPostsUseCase>(),
//       sl<FetchUserPostsUseCase>(),
//       sl<LikePostUseCase>(),
//       sl<DisLikePostUseCase>(),
//     ),
//   );
// }
