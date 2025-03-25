part of 'post_preview_bloc.dart';

sealed class PostPreviewState extends Equatable {
  const PostPreviewState();

  @override
  List<Object> get props => [];
}

final class PostPreviewInitial extends PostPreviewState {}

final class PostPreviewLoading extends PostPreviewState {}

final class PostPreviewLoaded extends PostPreviewState {
  final PostEntity post;
  const PostPreviewLoaded(this.post);
}
