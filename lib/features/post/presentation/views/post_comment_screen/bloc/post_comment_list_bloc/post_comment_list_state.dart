part of 'post_comment_list_bloc.dart';

abstract class PostCommentListState extends Equatable {
  const PostCommentListState();

  @override
  List<Object?> get props => [];
}

class PostCommentListInitial extends PostCommentListState {}

class PostCommentListLoading extends PostCommentListState {}

class PostCommentListLoaded extends PostCommentListState {
  final List<CommentEntity> comments;
  final int currentPage;
  final int pageSize;
  final int postId;
  final int userId;
  final int? parentCommentId;

  const PostCommentListLoaded({
    required this.comments,
    required this.currentPage,
    required this.pageSize,
    required this.postId,
    required this.userId,
    required this.parentCommentId,
  });

  @override
  List<Object?> get props => [
    comments,
    currentPage,
    pageSize,
    postId,
    userId,
    parentCommentId ?? '',
  ];
}

class PostCommentListLoadingMore extends PostCommentListState {
  final List<CommentEntity> comments;

  const PostCommentListLoadingMore(this.comments);

  @override
  List<Object?> get props => [comments];
}

class PostCommentListError extends PostCommentListState {
  final String message;

  const PostCommentListError(this.message);

  @override
  List<Object?> get props => [message];
}
