part of 'users_followers_bloc.dart';

abstract class UserFollowersEvent extends Equatable {
  const UserFollowersEvent();

  @override
  List<Object?> get props => [];
}

class FetchUserFollowers extends UserFollowersEvent {
  final int userId;
  final int page;

  const FetchUserFollowers({required this.userId, required this.page});

  @override
  List<Object?> get props => [userId, page];
}
