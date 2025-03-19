part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final bool loading;
  final List<PostEntity> posts;
  final String error;

  const ProfileState({
    required this.loading,
    required this.posts,
    required this.error,
  });

  ProfileState copyWith({
    bool? loading,
    List<PostEntity>? posts,
    String? error,
  }) {
    return ProfileState(
      loading: loading ?? this.loading,
      posts: posts ?? this.posts,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [loading, posts, error];
}
