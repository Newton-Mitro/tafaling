import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/constants/constants.dart';
import 'package:tafaling/core/utils/local_storage.dart';
import 'package:tafaling/features/post/domain/entities/post_entity.dart';
import 'package:tafaling/features/post/domain/usecases/fetch_posts_usecase.dart';
import 'package:tafaling/features/post/domain/usecases/fetch_user_posts_usecase.dart';
import 'package:tafaling/features/user/data/models/user_model.dart';

part 'posts_screen_event.dart';
part 'posts_screen_state.dart';

const int postsPerPage = 5;

class PostsScreenBloc extends Bloc<PostsScreenEvent, PostsScreenState> {
  final FetchPostsUseCase fetchPostsUseCase;
  final FetchUserPostsUseCase fetchUserPostsUseCase;
  final LocalStorage localStorage;
  int _fetchPage = 1;

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
  }
}
