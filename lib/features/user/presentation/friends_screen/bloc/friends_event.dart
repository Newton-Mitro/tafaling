part of 'friends_bloc.dart';

abstract class FriendsEvent extends Equatable {
  const FriendsEvent();

  @override
  List<Object?> get props => [];
}

class FetchFriends extends FriendsEvent {
  final int userId;
  final int page;

  const FetchFriends({required this.userId, required this.page});

  @override
  List<Object?> get props => [userId, page];
}
