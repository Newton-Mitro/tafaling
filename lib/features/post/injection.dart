import 'package:tafaling/core/injection.dart';
import 'package:tafaling/core/network/api_service.dart';
import 'package:tafaling/core/network/network_info.dart';
import 'package:tafaling/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:tafaling/features/post/data/data_sources/post_remote_data_source.dart';
import 'package:tafaling/features/post/data/repositories/post_repository_impl.dart';
import 'package:tafaling/features/post/domain/repositories/post_repository.dart';
import 'package:tafaling/features/post/domain/usecases/comment_on_post_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/create_post_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/delete_post_comment_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/dis_like_post_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/fetch_posts_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/fetch_user_posts_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/get_post_liked_users_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/get_user_post_comments_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/like_post_comment_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/like_post_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/share_post_usecase.dart';
import 'package:tafaling/features/post/presentation/views/create_post_screen/bloc/create_post_bloc.dart';
import 'package:tafaling/features/post/presentation/views/post_comment_screen/bloc/post_comment_bloc/post_comment_bloc.dart';
import 'package:tafaling/features/post/presentation/views/post_comment_screen/bloc/post_comment_list_bloc/post_comment_list_bloc.dart';
import 'package:tafaling/features/post/presentation/views/post_liked_users_screen/bloc/post_liked_users_bloc.dart';
import 'package:tafaling/features/post/presentation/views/share_post_screen/bloc/share_post_bloc.dart';
import 'package:tafaling/features/post/presentation/widgets/post_viewer/bloc/post_preview_bloc.dart';
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

  sl.registerLazySingleton(
    () => LikePostCommentUseCase(repository: sl<PostRepository>()),
  );

  sl.registerLazySingleton(
    () => DeletePostCommentUseCase(repository: sl<PostRepository>()),
  );

  sl.registerLazySingleton(
    () => GetUserPostCommentsUseCase(repository: sl<PostRepository>()),
  );

  sl.registerLazySingleton(
    () => CommentOnPostUseCase(repository: sl<PostRepository>()),
  );

  sl.registerLazySingleton(
    () => SharePostUseCase(repository: sl<PostRepository>()),
  );

  sl.registerLazySingleton(
    () => CreatePostUseCase(repository: sl<PostRepository>()),
  );

  // Bloc
  sl.registerFactory(
    () => PostsScreenBloc(
      fetchPostsUseCase: sl<FetchPostsUseCase>(),
      fetchUserPostsUseCase: sl<FetchUserPostsUseCase>(),
      getAuthUserUseCase: sl<GetAuthUserUseCase>(),
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

  sl.registerFactory(
    () => PostCommentListBloc(
      fetchPostComments: sl<GetUserPostCommentsUseCase>(),
    ),
  );

  sl.registerFactory(
    () => PostCommentBloc(
      commentOnPost: sl<CommentOnPostUseCase>(),
      deleteComment: sl<DeletePostCommentUseCase>(),
    ),
  );

  sl.registerFactory(
    () => CreatePostBloc(createPostUseCase: sl<CreatePostUseCase>()),
  );

  sl.registerFactory(
    () => SharePostBloc(sharePostUseCase: sl<SharePostUseCase>()),
  );
}
