part of 'post_comment_like_bloc.dart';

abstract class PostCommentLikeState extends Equatable {
  const PostCommentLikeState();

  @override
  List<Object?> get props => [];
}

class CommentLikeInitial extends PostCommentLikeState {}

class CommentLikeLoading extends PostCommentLikeState {}

class CommentLikeSuccess extends PostCommentLikeState {}

class CommentLikeError extends PostCommentLikeState {
  final String message;

  const CommentLikeError(this.message);

  @override
  List<Object?> get props => [message];
}
