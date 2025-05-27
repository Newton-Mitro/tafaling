part of 'post_comment_bloc.dart';

abstract class PostCommentEvent extends Equatable {
  const PostCommentEvent();
}

class SubmitPostComment extends PostCommentEvent {
  final int postId;
  final String comment;
  final int? parentId;

  const SubmitPostComment({
    required this.postId,
    required this.comment,
    this.parentId,
  });

  @override
  List<Object?> get props => [postId, comment, parentId];
}

class DeletePostComment extends PostCommentEvent {
  final int commentId;
  final int userId;
  const DeletePostComment(this.commentId, this.userId);

  @override
  List<Object?> get props => [commentId, userId];
}
