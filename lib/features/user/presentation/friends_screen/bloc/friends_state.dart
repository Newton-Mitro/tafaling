part of 'friends_bloc.dart';

abstract class FriendsState extends Equatable {
  const FriendsState();

  @override
  List<Object?> get props => [];
}

class FriendsInitial extends FriendsState {}

class FriendsLoading extends FriendsState {}

class FriendsLoadingMore extends FriendsState {}

class FriendsLoaded extends FriendsState {
  final List<UserEntity> followers;

  const FriendsLoaded({required this.followers});

  @override
  List<Object?> get props => [followers];
}

class FriendsLoadedWithMore extends FriendsState {
  final List<UserEntity> followers;
  final bool hasMore;

  const FriendsLoadedWithMore({required this.followers, required this.hasMore});

  @override
  List<Object?> get props => [followers, hasMore];
}

class FriendsError extends FriendsState {
  final String message;

  const FriendsError({required this.message});

  @override
  List<Object?> get props => [message];
}

class FriendsErrorWithMore extends FriendsState {
  final String message;
  final List<UserEntity> followers;

  const FriendsErrorWithMore({required this.message, required this.followers});

  @override
  List<Object?> get props => [message, followers];
}
