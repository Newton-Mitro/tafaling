import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tafaling/core/usecases/usecase.dart';
import 'package:tafaling/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';
import 'package:tafaling/features/user/domain/usecases/follow_user_usecase.dart';
import 'package:tafaling/features/user/domain/usecases/un_follow_user_usecase.dart';

part 'my_profile_event.dart';
part 'my_profile_state.dart';

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {
  final FollowUserUseCase followUserUseCase;
  final UnFollowUserUseCase unFollowUserUseCase;
  final GetAuthUserUseCase getAuthUserUseCase;

  MyProfileBloc({
    required this.followUserUseCase,
    required this.unFollowUserUseCase,
    required this.getAuthUserUseCase,
  }) : super(ProfileInitial()) {
    on<LoadUserProfileEvent>(_onProfileLoadEvent);
    on<FollowUserEvent>(_onFollowUserEvent);
    on<UnfollowUserEvent>(_onUnfollowUserEvent);
  }

  void _onProfileLoadEvent(
    LoadUserProfileEvent event,
    Emitter<MyProfileState> emit,
  ) async {
    final authUser = await getAuthUserUseCase(NoParams());

    authUser.fold((failure) => {}, (user) => emit(ProfileLoaded(user.user)));
  }

  void _onFollowUserEvent(
    FollowUserEvent event,
    Emitter<MyProfileState> emit,
  ) async {
    if (state is ProfileLoaded) {
      final currentUser = (state as ProfileLoaded).user;

      emit(ProfileLoading());
      final followUserPrams = FollowUserParams(followingUserId: event.userId);
      final dataState = await followUserUseCase(followUserPrams);
      dataState.fold(
        (failure) =>
            emit(ProfileLoaded(currentUser.copyWith(isFollowing: false))),
        (data) => emit(
          ProfileLoaded(
            currentUser.copyWith(
              isFollowing: true,
              followers: data.followingCount,
            ),
          ),
        ),
      );
    }
  }

  void _onUnfollowUserEvent(
    UnfollowUserEvent event,
    Emitter<MyProfileState> emit,
  ) async {
    if (state is ProfileLoaded) {
      final currentUser = (state as ProfileLoaded).user;

      emit(ProfileLoading());
      final unfollowUserPrams = UnFollowUserParams(
        followingUserId: event.userId,
      );
      final dataState = await unFollowUserUseCase(unfollowUserPrams);
      dataState.fold(
        (failure) =>
            emit(ProfileLoaded(currentUser.copyWith(isFollowing: true))),
        (data) => emit(
          ProfileLoaded(
            currentUser.copyWith(
              isFollowing: false,
              followers: data.followingCount,
            ),
          ),
        ),
      );
    }
  }
}
