part of 'post_preview_bloc.dart';

abstract class PostPreviewState extends Equatable {
  const PostPreviewState();

  @override
  List<Object?> get props => [];
}

class PostPreviewInitial extends PostPreviewState {}

class PostPreviewLoading extends PostPreviewState {}

class PostPreviewLoaded extends PostPreviewState {
  final PostEntity post;

  const PostPreviewLoaded(this.post);

  @override
  List<Object?> get props => [post];
}

class PostPreviewError extends PostPreviewState {
  final String message;

  const PostPreviewError({required this.message});

  @override
  List<Object?> get props => [message];
}
