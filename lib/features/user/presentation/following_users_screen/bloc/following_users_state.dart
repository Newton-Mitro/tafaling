part of 'following_users_bloc.dart';

abstract class FollowingUsersState extends Equatable {
  const FollowingUsersState();

  @override
  List<Object> get props => [];
}

class FollowingUsersInitial extends FollowingUsersState {}

class FollowingUsersLoading extends FollowingUsersState {}

class FollowingUsersLoadingMore extends FollowingUsersState {
  final List<UserEntity> followers;

  const FollowingUsersLoadingMore({required this.followers});

  @override
  List<Object> get props => [followers];
}

class FollowingUsersLoaded extends FollowingUsersState {
  final List<UserEntity> followers;

  const FollowingUsersLoaded({required this.followers});

  @override
  List<Object> get props => [followers];
}

class FollowingUsersError extends FollowingUsersState {
  final String message;

  const FollowingUsersError({required this.message});

  @override
  List<Object> get props => [message];
}

class FollowingUsersErrorWithMore extends FollowingUsersState {
  final String message;
  final List<UserEntity> followers;

  const FollowingUsersErrorWithMore({
    required this.message,
    required this.followers,
  });

  @override
  List<Object> get props => [message, followers];
}
