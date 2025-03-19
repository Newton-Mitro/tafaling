part of 'post_liked_users_bloc.dart';

abstract class PostLikedUsersState extends Equatable {
  const PostLikedUsersState();

  @override
  List<Object?> get props => [];
}

class PostLikedUsersInitial extends PostLikedUsersState {}

class PostLikedUsersLoading extends PostLikedUsersState {}

class PostLikedUsersLoadingMore extends PostLikedUsersState {}

class PostLikedUsersLoaded extends PostLikedUsersState {
  final List<UserEntity> followers;

  const PostLikedUsersLoaded({required this.followers});

  @override
  List<Object?> get props => [followers];
}

class PostLikedUsersLoadedWithMore extends PostLikedUsersState {
  final List<UserEntity> followers;
  final bool hasMore;

  const PostLikedUsersLoadedWithMore({
    required this.followers,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [followers, hasMore];
}

class PostLikedUsersError extends PostLikedUsersState {
  final String message;

  const PostLikedUsersError({required this.message});

  @override
  List<Object?> get props => [message];
}

class PostLikedUsersErrorWithMore extends PostLikedUsersState {
  final String message;
  final List<UserEntity> followers;

  const PostLikedUsersErrorWithMore({
    required this.message,
    required this.followers,
  });

  @override
  List<Object?> get props => [message, followers];
}
