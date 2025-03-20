part of 'posts_screen_bloc.dart';

sealed class PostsScreenEvent extends Equatable {
  const PostsScreenEvent();

  @override
  List<Object> get props => [];
}

final class InitPostsScreenEvent extends PostsScreenEvent {
  const InitPostsScreenEvent();

  @override
  List<Object> get props => [];
}

final class FetchPostsEvent extends PostsScreenEvent {
  const FetchPostsEvent();

  @override
  List<Object> get props => [];
}

final class LikePostEvent extends PostsScreenEvent {
  final int id;

  const LikePostEvent(this.id);

  @override
  List<Object> get props => [id];
}

final class DisLikePostEvent extends PostsScreenEvent {
  final int id;

  const DisLikePostEvent(this.id);

  @override
  List<Object> get props => [id];
}

final class PageChangeEvent extends PostsScreenEvent {
  final int currentPage;

  const PageChangeEvent({required this.currentPage});
}

final class FetchUserProfileEvent extends PostsScreenEvent {
  final int userId;

  const FetchUserProfileEvent(this.userId);

  @override
  List<Object> get props => [userId];
}
