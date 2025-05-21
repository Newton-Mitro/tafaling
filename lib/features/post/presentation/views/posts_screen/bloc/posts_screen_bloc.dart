import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:tafaling/features/post/domain/entities/post_entity.dart';
import 'package:tafaling/features/post/domain/usecases/fetch_posts_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/fetch_user_posts_usecase.dart';

part 'posts_screen_event.dart';
part 'posts_screen_state.dart';

class PostsScreenBloc extends Bloc<PostsScreenEvent, PostsScreenState> {
  final FetchPostsUseCase fetchPostsUseCase;
  final FetchUserPostsUseCase fetchUserPostsUseCase;
  final GetAuthUserUseCase getAuthUserUseCase;

  int currentPage = 0;
  final int pageSize = 10;
  bool hasMorePosts = true;
  bool isLoading = false;

  PostsScreenBloc({
    required this.fetchPostsUseCase,
    required this.fetchUserPostsUseCase,
    required this.getAuthUserUseCase,
  }) : super(const PostsScreenState(posts: [], isFetching: false, error: '')) {
    on<InitPostsScreenEvent>(_onInitPostsScreen);
    on<FetchPostsEvent>(_onFetchPosts);
    on<PageChangeEvent>(_onPageChange);
  }

  Future<void> _onInitPostsScreen(
    InitPostsScreenEvent event,
    Emitter<PostsScreenState> emit,
  ) async {
    currentPage = 0;
    hasMorePosts = true;
    isLoading = false;
    emit(const PostsScreenState(posts: [], isFetching: false, error: ''));
    add(const FetchPostsEvent());
  }

  Future<void> _onFetchPosts(
    FetchPostsEvent event,
    Emitter<PostsScreenState> emit,
  ) async {
    if (isLoading || !hasMorePosts) return;

    isLoading = true;
    emit(state.copyWith(isFetching: true));

    final authUserResult = await getAuthUserUseCase.call(NoParams());

    var authUserId = 0;

    authUserResult.fold(
      (failure) {
        authUserId = 0;
      },
      (authUser) {
        authUserId = authUser.user.id;
      },
    );

    final result = await fetchPostsUseCase(
      FetchPostsPrams(
        userId: authUserId,
        startRecord: currentPage * pageSize,
        pageSize: pageSize,
      ),
    );

    result.fold(
      (failure) {
        isLoading = false;
        emit(state.copyWith(isFetching: false, error: failure.message));
      },
      (newPosts) {
        isLoading = false;

        final updatedPosts = [...state.posts, ...newPosts];
        hasMorePosts = newPosts.length == pageSize;

        if (hasMorePosts) currentPage++;

        emit(state.copyWith(posts: updatedPosts, isFetching: false, error: ''));
      },
    );
  }

  void _onPageChange(PageChangeEvent event, Emitter<PostsScreenState> emit) {
    if (event.pageIndex >= state.posts.length - 1 &&
        !isLoading &&
        hasMorePosts) {
      add(const FetchPostsEvent());
    }
  }
}
