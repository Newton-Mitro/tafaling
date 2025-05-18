import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/services/local_storage/local_storage.dart';
import 'package:tafaling/features/post/domain/entities/post_entity.dart';
import 'package:tafaling/features/post/domain/usecases/fetch_posts_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/fetch_user_posts_usecase.dart';

part 'posts_screen_event.dart';
part 'posts_screen_state.dart';

const int postsPerPage = 5;

class PostsScreenBloc extends Bloc<PostsScreenEvent, PostsScreenState> {
  final FetchPostsUseCase fetchPostsUseCase;
  final FetchUserPostsUseCase fetchUserPostsUseCase;
  final LocalStorage localStorage;

  PostsScreenBloc({
    required this.fetchPostsUseCase,
    required this.fetchUserPostsUseCase,
    required this.localStorage,
  }) : super(
         const PostsScreenState(
           isFetching: false,
           posts: [],
           currentPage: 0,
           error: '',
         ),
       ) {
    on<PageChangeEvent>(_onPageChange);
    on<InitPostsScreenEvent>(_onInitPostsScreen);
    on<FetchPostsEvent>(_onFetchPosts);
  }

  Future<void> _onInitPostsScreen(
    InitPostsScreenEvent event,
    Emitter<PostsScreenState> emit,
  ) async {
    emit(
      state.copyWith(
        isFetching: false,
        posts: state.posts,
        currentPage: state.currentPage,
        error: '',
      ),
    );
  }

  Future<void> _onPageChange(
    PageChangeEvent event,
    Emitter<PostsScreenState> emit,
  ) async {
    if (event.currentPage != state.currentPage) {
      emit(state.copyWith(currentPage: event.currentPage));
    }
  }

  Future<void> _onFetchPosts(
    FetchPostsEvent event,
    Emitter<PostsScreenState> emit,
  ) async {
    emit(state.copyWith(isFetching: true, posts: state.posts));
  }
}
