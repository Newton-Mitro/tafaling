part of 'posts_screen_bloc.dart';

class PostsScreenState extends Equatable {
  final bool isFetching;
  final List<PostEntity> posts;
  final String? error;
  final int currentPage;

  const PostsScreenState({
    required this.isFetching,
    required this.posts,
    required this.currentPage,
    required this.error,
  });

  // Copy with method to update state immutably
  PostsScreenState copyWith({
    bool? isFetching,
    List<PostEntity>? posts,
    int? currentPage,
    String? error,
    int? loggedInUserId,
    int? loggedInState,
    int? profileUserId,
    int? profileState,
  }) {
    return PostsScreenState(
      isFetching: isFetching ?? this.isFetching,
      posts: posts ?? this.posts,
      currentPage: currentPage ?? this.currentPage,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isFetching, posts, currentPage, error];
}
