import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/utils/app_shared_pref.dart';
import 'package:tafaling/features/post/data/models/post_model.dart';
import 'package:tafaling/features/post/domain/usecases/dis_like_post_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/fetch_posts_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/fetch_user_posts_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/like_post_usecase.dart';

part 'posts_screen_event.dart';
part 'posts_screen_state.dart';

const int postsPerPage = 50;

class PostsScreenBloc extends Bloc<PostsScreenEvent, PostsScreenState> {
  final FetchPostsUseCase fetchPostsUseCase;
  final FetchUserPostsUseCase fetchUserPostsUseCase;
  final LikePostUseCase likePostUseCase;
  final DisLikePostUseCase disLikePostUseCase;
  int _fetchPage = 1;

  PostsScreenBloc(
    this.fetchPostsUseCase,
    this.fetchUserPostsUseCase,
    this.likePostUseCase,
    this.disLikePostUseCase,
  ) : super(const PostsScreenState(
            isFetching: false,
            posts: [],
            currentPage: 0,
            error: '',
            loggedInUserId: 0,
            loggedInState: 0,
            profileUserId: 0,
            profileState: 0)) {
    _onLoadState();

    on<LikePostEvent>(_onPostInteraction);
    on<DisLikePostEvent>(_onPostInteraction);
    on<FetchUserProfileEvent>(_onFetchUserProfile);
    on<PageChangeEvent>(_onPageChange);
    on<InitPostsScreenEvent>(_onInitPostsScreen);
    on<FetchPostsEvent>(_onFetchPosts);
  }

  _onLoadState() async {
    final credentials = await _getUserCredentials();
    final userId = credentials['userId'];
    final accessToken = credentials['accessToken'];
    emit(state.copyWith(
        isFetching: false,
        posts: state.posts,
        currentPage: state.currentPage,
        error: '',
        loggedInUserId: userId != null && accessToken != null ? userId : 0,
        loggedInState: 0,
        profileUserId: 0,
        profileState: 0));
  }

  Future<void> _onInitPostsScreen(
      InitPostsScreenEvent event, Emitter<PostsScreenState> emit) async {
    emit(state.copyWith(
        isFetching: false,
        posts: state.posts,
        currentPage: state.currentPage,
        error: '',
        loggedInUserId: 0,
        loggedInState: 0,
        profileUserId: 0,
        profileState: 0));
  }

  Future<Map<String, dynamic>> _getUserCredentials() async {
    final accessToken = await AppSharedPref.getAccessToken();
    final user = await AppSharedPref.getAuthUser();
    return {'userId': user?.id, 'accessToken': accessToken};
  }

  Future<void> _onPageChange(
      PageChangeEvent event, Emitter<PostsScreenState> emit) async {
    if (event.currentPage != state.currentPage) {
      emit(state.copyWith(currentPage: event.currentPage));
    }
  }

  Future<void> _onFetchPosts(
      FetchPostsEvent event, Emitter<PostsScreenState> emit) async {
    try {
      emit(state.copyWith(
        isFetching: true,
        posts: state.posts,
      ));

      final credentials = await _getUserCredentials();
      final userId = credentials['userId'];
      final accessToken = credentials['accessToken'];

      int startRecord = postsPerPage * (_fetchPage - 1);
      List<PostModel> posts = [];

      // Fetch posts based on authentication status
      if (accessToken == null) {
        posts = await fetchPostsUseCase(-1, startRecord, postsPerPage);
      } else if (userId != null) {
        posts = await fetchUserPostsUseCase(userId, startRecord, postsPerPage);
      }

      _fetchPage++;

      emit(state.copyWith(
        posts: state.posts + posts,
        isFetching: true, // Set isFetching to false after fetch is complete
      ));
    } catch (error) {
      emit(state.copyWith(
        isFetching: false,
        error: error.toString(),
      ));
    } finally {
      emit(state.copyWith(
        isFetching: false,
        error: '',
      ));
    }
  }

  Future<void> _onPostInteraction(
      PostsScreenEvent event, Emitter<PostsScreenState> emit) async {
    final credentials = await _getUserCredentials();
    final userId = credentials['userId'];
    final accessToken = credentials['accessToken'];
    if (accessToken == null) {
      emit(state.copyWith(
          loggedInUserId: 0,
          loggedInState: Random().nextInt(100) + 50, // Temporary random state
          profileUserId: 0,
          profileState: 0));
      return;
    }

    final isLike = event is LikePostEvent;
    final postId = isLike ? (event).id : (event as DisLikePostEvent).id;

    try {
      final likeModel = isLike
          ? await likePostUseCase(postId)
          : await disLikePostUseCase(postId);
      final updatedPosts =
          _updatePostLikeStatus(postId, likeModel.likeCount, isLike ? 1 : 0);

      emit(state.copyWith(posts: updatedPosts));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
    } finally {
      emit(state.copyWith(isFetching: false));
    }
  }

  List<PostModel> _updatePostLikeStatus(
      int postId, int likeCount, int isLiked) {
    final postIndex = state.posts.indexWhere((post) => post.id == postId);
    if (postIndex == -1) return state.posts;

    final updatedPost = state.posts[postIndex].copyWith(
      likeCount: likeCount,
      isLiked: isLiked == 1,
    );

    final updatedPosts = List<PostModel>.from(state.posts)
      ..[postIndex] = updatedPost;

    return updatedPosts;
  }

  Future<void> _onFetchUserProfile(
      FetchUserProfileEvent event, Emitter<PostsScreenState> emit) async {
    final credentials = await _getUserCredentials();
    final userId = credentials['userId'];
    final accessToken = credentials['accessToken'];
    if (accessToken == null) {
      emit(state.copyWith(
          loggedInUserId: 0,
          loggedInState: 0,
          profileUserId: 0,
          profileState: Random().nextInt(100) + 50)); // Temporary random state
    } else {
      emit(state.copyWith(
          loggedInUserId: 0,
          loggedInState: 0,
          profileUserId: event.userId,
          profileState: Random().nextInt(100) + 50)); // Temporary random state
    }
  }
}
