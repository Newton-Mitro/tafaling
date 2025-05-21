part of 'posts_screen_bloc.dart';

class PostsScreenState extends Equatable {
  final List<PostEntity> posts;
  final bool isFetching;
  final String error;

  const PostsScreenState({
    required this.posts,
    required this.isFetching,
    required this.error,
  });

  PostsScreenState copyWith({
    List<PostEntity>? posts,
    bool? isFetching,
    String? error,
  }) {
    return PostsScreenState(
      posts: posts ?? this.posts,
      isFetching: isFetching ?? this.isFetching,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [posts, isFetching, error];
}
