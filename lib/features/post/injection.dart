import 'package:get_it/get_it.dart';
import 'package:tafaling/core/index.dart';
import 'package:tafaling/features/post/presentation/views/post_liked_users_screen/bloc/post_liked_users_bloc.dart';
import 'package:tafaling/features/post/presentation/views/post_preview_screen/bloc/post_preview_bloc.dart';
import 'data/index.dart';
import 'domain/index.dart';
import 'presentation/index.dart';

final sl = GetIt.instance;

void registerPostModule() {
  // Data Sources
  sl.registerLazySingleton<PostDataSource>(
    () => PostRemoteDataSourceImpl(
      apiService: sl<ApiService>(),
      authApiService: sl<ApiService>(),
    ),
  );

  // Repository
  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(
      networkInfo: sl<NetworkInfo>(),
      postDataSource: sl<PostDataSource>(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(
    () => FetchPostsUseCase(postRepository: sl<PostRepository>()),
  );
  sl.registerLazySingleton(
    () => LikePostUseCase(postRepository: sl<PostRepository>()),
  );
  sl.registerLazySingleton(
    () => FetchUserPostsUseCase(postRepository: sl<PostRepository>()),
  );
  sl.registerLazySingleton(
    () => DisLikePostUseCase(postRepository: sl<PostRepository>()),
  );
  sl.registerLazySingleton(
    () => GetPostLikedUsersUsecase(postRepository: sl<PostRepository>()),
  );

  // Bloc
  sl.registerFactory(
    () => PostsScreenBloc(
      fetchPostsUseCase: sl<FetchPostsUseCase>(),
      fetchUserPostsUseCase: sl<FetchUserPostsUseCase>(),
      localStorage: sl<LocalStorage>(),
    ),
  );

  sl.registerFactory(
    () => PostPreviewBloc(
      likePostUseCase: sl<LikePostUseCase>(),
      disLikePostUseCase: sl<DisLikePostUseCase>(),
    ),
  );

  sl.registerFactory(
    () => PostLikedUsersBloc(
      getPostLikedUsersUsecase: sl<GetPostLikedUsersUsecase>(),
    ),
  );
}
