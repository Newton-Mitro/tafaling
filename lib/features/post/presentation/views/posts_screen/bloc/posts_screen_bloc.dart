import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/constants/constants.dart';
import 'package:tafaling/core/index.dart';
import 'package:tafaling/features/post/domain/entities/post_entity.dart';
import 'package:tafaling/features/post/domain/usecases/dis_like_post_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/fetch_posts_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/fetch_user_posts_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/like_post_usecase.dart';
import 'package:tafaling/features/user/data/models/user_model.dart';

part 'posts_screen_event.dart';
part 'posts_screen_state.dart';

const int postsPerPage = 5;

class PostsScreenBloc extends Bloc<PostsScreenEvent, PostsScreenState> {
  final FetchPostsUseCase fetchPostsUseCase;
  final FetchUserPostsUseCase fetchUserPostsUseCase;
  final LikePostUseCase likePostUseCase;
  final DisLikePostUseCase disLikePostUseCase;
  final LocalStorage localStorage;
  int _fetchPage = 1;

  PostsScreenBloc({
    required this.fetchPostsUseCase,
    required this.fetchUserPostsUseCase,
    required this.likePostUseCase,
    required this.disLikePostUseCase,
    required this.localStorage,
  }) : super(
         const PostsScreenState(
           isFetching: false,
           posts: [],
           currentPage: 0,
           error: '',
         ),
       ) {
    on<LikePostEvent>(_onPostInteraction);
    on<DisLikePostEvent>(_onPostInteraction);
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

  Future<Map<String, dynamic>> _getUserCredentials() async {
    final accessToken = await localStorage.getString(Constants.accessTokenKey);

    final authUser = await localStorage.getString(Constants.authUserKey);
    if (authUser == null) {
      return {'userId': null, 'accessToken': accessToken};
    }
    final user = UserModel.fromJson(jsonDecode(authUser));
    return {'userId': user.id, 'accessToken': accessToken};
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

    final credentials = await _getUserCredentials();
    final userId = credentials['userId'];
    final accessToken = credentials['accessToken'];

    int startRecord = postsPerPage * (_fetchPage - 1);

    // Fetch posts based on authentication status
    DataState dataState = FailedData(ServerFailure());
    if (accessToken == null) {
      final fetchUserParams = FetchPostsPrams(
        userId: -1,
        startRecord: startRecord,
        pageSize: postsPerPage,
      );

      dataState = await fetchPostsUseCase(params: fetchUserParams);
    } else if (userId != null) {
      final fetchUserDataParams = FetchUserPostsPrams(
        userId: userId,
        startRecord: startRecord,
        pageSize: postsPerPage,
      );

      dataState = await fetchUserPostsUseCase(params: fetchUserDataParams);
    }

    if (dataState is SuccessData && dataState.data != null) {
      emit(
        state.copyWith(
          posts: [...state.posts + dataState.data!],
          isFetching: false,
        ),
      );
      _fetchPage++;
    }
    if (dataState is FailedData && dataState.error != null) {
      emit(state.copyWith(isFetching: false, error: dataState.error!.message));
    }
  }

  Future<void> _onPostInteraction(
    PostsScreenEvent event,
    Emitter<PostsScreenState> emit,
  ) async {
    final isLikeEvent = event is LikePostEvent;
    final postId = isLikeEvent ? (event).id : (event as DisLikePostEvent).id;

    final likeParam = LikePostPrams(postId: postId);
    final disLikeParam = DisLikePostPrams(postId: postId);

    emit(state.copyWith(isFetching: true));

    final dataState =
        isLikeEvent
            ? await likePostUseCase(params: likeParam)
            : await disLikePostUseCase(params: disLikeParam);
    if (dataState is SuccessData) {
      final updatedPosts = _updatePostLikeStatus(
        postId,
        dataState.data?.likeCount ?? 0,
        isLikeEvent ? 1 : 0,
      );

      emit(state.copyWith(posts: updatedPosts));
    }

    if (dataState is FailedData && dataState.error != null) {
      emit(state.copyWith(isFetching: false, error: dataState.error!.message));
    }
  }

  List<PostEntity> _updatePostLikeStatus(
    int postId,
    int likeCount,
    int isLiked,
  ) {
    final postIndex = state.posts.indexWhere((post) => post.id == postId);
    if (postIndex == -1) return state.posts;

    final updatedPost = state.posts[postIndex].copyWith(
      likeCount: likeCount,
      isLiked: isLiked == 1,
    );

    final updatedPosts = List<PostEntity>.from(state.posts)
      ..[postIndex] = updatedPost;

    return updatedPosts;
  }
}
