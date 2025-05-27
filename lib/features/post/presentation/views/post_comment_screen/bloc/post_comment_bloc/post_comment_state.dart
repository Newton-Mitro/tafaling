part of 'post_comment_bloc.dart';

abstract class PostCommentState extends Equatable {
  const PostCommentState();

  @override
  List<Object?> get props => [];
}

class PostCommentInitial extends PostCommentState {}

class PostCommentSubmitting extends PostCommentState {}

class PostCommentSubmitted extends PostCommentState {}

class PostCommentError extends PostCommentState {
  final String message;
  const PostCommentError(this.message);
  @override
  List<Object?> get props => [message];
}
