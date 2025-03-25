part of 'post_preview_bloc.dart';

sealed class PostPreviewEvent extends Equatable {
  const PostPreviewEvent();

  @override
  List<Object> get props => [];
}

class LoadPostPreviewEvent extends PostPreviewEvent {
  final PostEntity post;
  const LoadPostPreviewEvent(this.post);
}

class PostLikeEvent extends PostPreviewEvent {
  final int postId;
  const PostLikeEvent(this.postId);
}

class RemovePostLikeEvent extends PostPreviewEvent {
  final int postId;
  const RemovePostLikeEvent(this.postId);
}
