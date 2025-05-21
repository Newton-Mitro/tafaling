part of 'posts_screen_bloc.dart';

abstract class PostsScreenEvent extends Equatable {
  const PostsScreenEvent();

  @override
  List<Object> get props => [];
}

class InitPostsScreenEvent extends PostsScreenEvent {
  const InitPostsScreenEvent();
}

class FetchPostsEvent extends PostsScreenEvent {
  const FetchPostsEvent();
}

class PageChangeEvent extends PostsScreenEvent {
  final int pageIndex;

  const PageChangeEvent({required this.pageIndex});

  @override
  List<Object> get props => [pageIndex];
}
