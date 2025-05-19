import 'package:tafaling/core/injection.dart';
import 'package:tafaling/core/network/api_service.dart';
import 'package:tafaling/core/network/network_info.dart';
import 'package:tafaling/core/services/local_storage/local_storage.dart';
import 'package:tafaling/features/post/data/data_sources/post_remote_data_source.dart';
import 'package:tafaling/features/post/data/repositories/post_repository_impl.dart';
import 'package:tafaling/features/post/domain/repositories/post_repository.dart';
import 'package:tafaling/features/post/domain/usecases/dis_like_post_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/fetch_posts_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/fetch_user_posts_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/get_post_liked_users_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/like_post_usecase.dart';
import 'package:tafaling/features/post/presentation/views/post_liked_users_screen/bloc/post_liked_users_bloc.dart';
import 'package:tafaling/features/post/presentation/views/post_preview_screen/bloc/post_preview_bloc.dart';
import 'package:tafaling/features/post/presentation/views/posts_screen/bloc/posts_screen_bloc.dart';

void registerPostModule() {
  // Data Sources
  sl.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSourceImpl(
      apiService: sl<ApiService>(),
      authApiService: sl<ApiService>(),
    ),
  );

  // Repository
  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(
      networkInfo: sl<NetworkInfo>(),
      postDataSource: sl<PostRemoteDataSource>(),
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
