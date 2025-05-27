part of 'post_comment_like_bloc.dart';

abstract class PostCommentLikeEvent extends Equatable {
  const PostCommentLikeEvent();
}

class LikeComment extends PostCommentLikeEvent {
  final int commentId;
  final int userId;

  const LikeComment(this.commentId, this.userId);

  @override
  List<Object?> get props => [commentId, userId];
}

class UnlikeComment extends PostCommentLikeEvent {
  final int commentId;
  final int userId;

  const UnlikeComment(this.commentId, this.userId);

  @override
  List<Object?> get props => [commentId, userId];
}
