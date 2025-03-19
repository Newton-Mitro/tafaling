part of 'post_liked_users_bloc.dart';

abstract class PostLikedUsersEvent extends Equatable {
  const PostLikedUsersEvent();

  @override
  List<Object?> get props => [];
}

class FetchPostLikedUsers extends PostLikedUsersEvent {
  final int postId;
  final int page;

  const FetchPostLikedUsers({required this.postId, required this.page});

  @override
  List<Object?> get props => [postId, page];
}
