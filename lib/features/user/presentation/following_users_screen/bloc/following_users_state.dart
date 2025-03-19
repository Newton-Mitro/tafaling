part of 'following_users_bloc.dart';

abstract class FollowingUsersState extends Equatable {
  const FollowingUsersState();

  @override
  List<Object?> get props => [];
}

class FollowingUsersInitial extends FollowingUsersState {}

class FollowingUsersLoading extends FollowingUsersState {}

class FollowingUsersLoadingMore extends FollowingUsersState {}

class FollowingUsersLoaded extends FollowingUsersState {
  final List<UserEntity> followers;

  const FollowingUsersLoaded({required this.followers});

  @override
  List<Object?> get props => [followers];
}

class FollowingUsersLoadedWithMore extends FollowingUsersState {
  final List<UserEntity> followers;
  final bool hasMore;

  const FollowingUsersLoadedWithMore({
    required this.followers,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [followers, hasMore];
}

class FollowingUsersError extends FollowingUsersState {
  final String message;

  const FollowingUsersError({required this.message});

  @override
  List<Object?> get props => [message];
}

class FollowingUsersErrorWithMore extends FollowingUsersState {
  final String message;
  final List<UserEntity> followers;

  const FollowingUsersErrorWithMore({
    required this.message,
    required this.followers,
  });

  @override
  List<Object?> get props => [message, followers];
}
