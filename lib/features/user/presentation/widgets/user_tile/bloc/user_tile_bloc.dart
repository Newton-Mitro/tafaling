import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';
import 'package:tafaling/features/user/domain/usecases/follow_user_usecase.dart';
import 'package:tafaling/features/user/domain/usecases/un_follow_user_usecase.dart';

part 'user_tile_event.dart';
part 'user_tile_state.dart';

class UserTileBloc extends Bloc<UserTileEvent, UserTileState> {
  final FollowUserUseCase followUserUseCase;
  final UnFollowUserUseCase unFollowUserUseCase;

  UserTileBloc({
    required this.followUserUseCase,
    required this.unFollowUserUseCase,
  }) : super(UserTileInitial()) {
    on<LoadUserEvent>(_onUserTileLoadEvent);
    on<FollowUserEvent>(_onFollowUserEvent);
    on<UnfollowUserEvent>(_onUnfollowUserEvent);
  }

  void _onUserTileLoadEvent(
    LoadUserEvent event,
    Emitter<UserTileState> emit,
  ) async {
    emit(UserTileLoading());
    emit(UserTileLoaded(event.user));
  }

  void _onFollowUserEvent(
    FollowUserEvent event,
    Emitter<UserTileState> emit,
  ) async {
    if (state is UserTileLoaded) {
      final currentUser = (state as UserTileLoaded).user;

      emit(UserTileLoading());
      final followUserPrams = FollowUserParams(followingUserId: event.userId);
      final dataState = await followUserUseCase(followUserPrams);
      dataState.fold(
        (failure) =>
            emit(UserTileLoaded(currentUser.copyWith(isFollowing: false))),
        (data) => emit(UserTileLoaded(currentUser.copyWith(isFollowing: true))),
      );
    }
  }

  void _onUnfollowUserEvent(
    UnfollowUserEvent event,
    Emitter<UserTileState> emit,
  ) async {
    if (state is UserTileLoaded) {
      final currentUser = (state as UserTileLoaded).user;

      emit(UserTileLoading());
      final unfollowUserPrams = UnFollowUserParams(
        followingUserId: event.userId,
      );
      final dataState = await unFollowUserUseCase(unfollowUserPrams);
      dataState.fold(
        (failure) =>
            emit(UserTileLoaded(currentUser.copyWith(isFollowing: true))),
        (data) =>
            emit(UserTileLoaded(currentUser.copyWith(isFollowing: false))),
      );
    }
  }
}
