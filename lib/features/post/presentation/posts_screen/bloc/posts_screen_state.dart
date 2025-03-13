part of 'posts_screen_bloc.dart';

class PostsScreenState extends Equatable {
  final bool isFetching;
  final List<PostModel> posts;
  final int currentPage;
  final String? error;
  final int loggedInUserId;
  final int loggedInState;
  final int profileUserId;
  final int profileState;

  const PostsScreenState(
      {required this.isFetching,
      required this.posts,
      required this.currentPage,
      required this.error,
      required this.loggedInUserId,
      required this.loggedInState,
      required this.profileUserId,
      required this.profileState});

  // Copy with method to update state immutably
  PostsScreenState copyWith(
      {bool? isFetching,
      List<PostModel>? posts,
      int? currentPage,
      String? error,
      int? loggedInUserId,
      int? loggedInState,
      int? profileUserId,
      int? profileState}) {
    return PostsScreenState(
      isFetching: isFetching ?? this.isFetching,
      posts: posts ?? this.posts,
      currentPage: currentPage ?? this.currentPage,
      error: error ?? this.error,
      loggedInUserId: loggedInUserId ?? this.loggedInUserId,
      loggedInState: loggedInState ?? this.loggedInState,
      profileUserId: profileUserId ?? this.profileUserId,
      profileState: profileState ?? this.profileState,
    );
  }

  @override
  List<Object?> get props => [
        isFetching,
        posts,
        currentPage,
        error,
        profileUserId,
        loggedInUserId,
        loggedInState,
        profileState
      ];
}
