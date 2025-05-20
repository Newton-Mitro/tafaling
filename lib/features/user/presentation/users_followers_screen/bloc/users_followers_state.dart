part of 'users_followers_bloc.dart';

abstract class UserFollowersState extends Equatable {
  const UserFollowersState();

  @override
  List<Object> get props => [];
}

class UserFollowersInitial extends UserFollowersState {}

class UserFollowersLoading extends UserFollowersState {}

class UserFollowersLoadingMore extends UserFollowersState {}

class UserFollowersLoaded extends UserFollowersState {
  final List<UserEntity> followers;

  const UserFollowersLoaded({required this.followers});

  @override
  List<Object> get props => [followers];
}

class UserFollowersError extends UserFollowersState {
  final String message;

  const UserFollowersError({required this.message});

  @override
  List<Object> get props => [message];
}

class UserFollowersErrorWithMore extends UserFollowersState {
  final String message;
  final List<UserEntity> followers;

  const UserFollowersErrorWithMore({
    required this.message,
    required this.followers,
  });

  @override
  List<Object> get props => [message, followers];
}
