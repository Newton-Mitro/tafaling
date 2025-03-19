part of 'following_users_bloc.dart';

abstract class FollowingUsersEvent extends Equatable {
  const FollowingUsersEvent();

  @override
  List<Object?> get props => [];
}

class FetchFollowingUsers extends FollowingUsersEvent {
  final int userId;
  final int page;

  const FetchFollowingUsers({required this.userId, required this.page});

  @override
  List<Object?> get props => [userId, page];
}
