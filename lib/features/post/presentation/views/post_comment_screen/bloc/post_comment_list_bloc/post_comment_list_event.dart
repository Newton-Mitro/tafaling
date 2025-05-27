part of 'post_comment_list_bloc.dart';

abstract class PostCommentListEvent extends Equatable {
  const PostCommentListEvent();

  @override
  List<Object?> get props => [];
}

class LoadPostComments extends PostCommentListEvent {
  final int postId;
  final int userId;
  final int? parentCommentId;
  final int pageSize;

  const LoadPostComments({
    required this.postId,
    required this.userId,
    this.parentCommentId,
    this.pageSize = 20,
  });

  @override
  List<Object?> get props => [postId, userId, parentCommentId, pageSize];
}

class LoadMorePostComments extends PostCommentListEvent {
  const LoadMorePostComments();

  @override
  List<Object?> get props => [];
}
