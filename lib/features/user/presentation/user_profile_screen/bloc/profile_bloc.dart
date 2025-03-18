import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tafaling/core/resources/response_state.dart';
import 'package:tafaling/features/post/data/models/post_model.dart';
import 'package:tafaling/features/user/data/models/user_model.dart';
import 'package:tafaling/features/user/domain/usecases/fetch_profile_usecase.dart';
import 'package:tafaling/features/user/domain/usecases/follow_user_usecase.dart';
import 'package:tafaling/features/user/domain/usecases/un_follow_user_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

const int postsPerPage = 20;

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FetchProfileUseCase fetchProfileUseCase;
  final FollowUserUseCase followUserUseCase;
  final UnFollowUserUseCase unFollowUserUseCase;

  ProfileBloc(
    this.fetchProfileUseCase,
    this.followUserUseCase,
    this.unFollowUserUseCase,
  ) : super(const ProfileState(loading: false, posts: [], error: '')) {
    on<FetchProfileEvent>(_onFetchProfile);
    on<FollowUserEvent>(_onFollowUserEvent);
    on<UnFollowUserEvent>(_onUnFollowUserEvent);
  }

  void _onFetchProfile(
    FetchProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(loading: true));

    var startRecord = (postsPerPage * (event.fetchPage - 1));
    final fetchProfileParams = FetchProfileParams(
      userId: event.userId,
      startRecord: startRecord,
      pageSize: postsPerPage,
    );

    final dataState = await fetchProfileUseCase.call(
      params: fetchProfileParams,
    );
    if (dataState is SuccessData && dataState.data != null) {
      final updatedPosts = List<PostModel>.from(state.posts)
        ..addAll(dataState.data!);
      emit(state.copyWith(posts: updatedPosts, loading: false));
    }

    if (dataState is FailedData && dataState.error != null) {
      emit(state.copyWith(error: dataState.error!.message, loading: false));
    }
  }

  Future<void> _onFollowUserEvent(
    FollowUserEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(loading: true));
    final followUserParams = FollowUserParams(
      followingUserId: event.followingUserId,
    );
    await followUserUseCase.call(params: followUserParams);
    final updatedPosts = _updateSearchUsers(event.followingUserId);
    emit(state.copyWith(posts: updatedPosts, loading: false));
  }

  Future<void> _onUnFollowUserEvent(
    UnFollowUserEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(loading: true));
    final unFollowUserParams = UnFollowUserParams(
      followingUserId: event.followingUserId,
    );
    await unFollowUserUseCase(params: unFollowUserParams);
    final updatedPosts = _updateSearchUsers(event.followingUserId);
    emit(state.copyWith(posts: updatedPosts, loading: false));
  }

  List<PostModel> _updateSearchUsers(int userId) {
    final isFollowing = !state.posts[0].creator.isFollowing;
    final updatedUser = (state.posts[0].creator as UserModel).copyWith(
      isFollowing: isFollowing,
    );
    final updatedPost = state.posts[0].copyWith(creator: updatedUser);
    final updatedPosts = List<PostModel>.from(state.posts)..[0] = updatedPost;
    return updatedPosts;
  }
}
