import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/utils/shared_prefs.dart';
import 'package:tafaling/features/post/data/models/post_model.dart';
import 'package:tafaling/features/user/domain/usecases/fetch_profile_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

const int postsPerPage = 20;

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FetchProfileUseCase fetchProfileUseCase;

  ProfileBloc(
    this.fetchProfileUseCase,
  ) : super(const ProfileState(
          loading: false,
          posts: [],
          error: '',
        )) {
    on<FetchProfileEvent>(_onFetchProfile);
  }

  // Retrieves the access token from shared preferences
  Future<String?> _getAccessToken() async {
    return await SharedPrefs.getAccessToken();
  }

  // Retrieves the user data from shared preferences
  Future<Map<String, dynamic>?> _getUserData() async {
    final user = await SharedPrefs.getUser();
    return user != null ? jsonDecode(user) : null;
  }

  // Handles fetching posts
  void _onFetchProfile(
      FetchProfileEvent event, Emitter<ProfileState> emit) async {
    final accessToken = await _getAccessToken();
    final user = await _getUserData();

    emit(state.copyWith(loading: true));

    try {
      // final oldPosts = state.posts;
      var startRecord = (postsPerPage * (event.fetchPage - 1));
      final newPosts =
          await _fetchNewPosts(accessToken, event.userId, startRecord);
      // Append new posts to the existing list
      final updatedPosts = List<PostModel>.from(state.posts)..addAll(newPosts);
      emit(state.copyWith(loading: false, error: '', posts: updatedPosts));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  // Fetch new posts based on the access token and user data
  Future<List<PostModel>> _fetchNewPosts(
      String? accessToken, int userId, int startRecord) {
    if (accessToken == null) {
      return fetchProfileUseCase.call(-1, startRecord, postsPerPage);
    }
    return fetchProfileUseCase.call(userId, startRecord, postsPerPage);
  }
}
