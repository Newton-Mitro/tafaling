import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/injection.dart';
import 'package:tafaling/features/post/presentation/views/post_liked_users_screen/bloc/post_liked_users_bloc.dart';
import 'package:tafaling/features/user/presentation/widgets/user_tile/user_tile.dart';

class PostLikedUsersScreen extends StatefulWidget {
  final int userId;

  const PostLikedUsersScreen({super.key, required this.userId});

  @override
  State<PostLikedUsersScreen> createState() => _PostLikedUsersScreenState();
}

class _PostLikedUsersScreenState extends State<PostLikedUsersScreen> {
  late PostLikedUsersBloc postLikedUsersBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        postLikedUsersBloc.hasMoreFollowers &&
        postLikedUsersBloc.state is! PostLikedUsersLoadingMore) {
      postLikedUsersBloc.add(
        FetchPostLikedUsers(
          postId: widget.userId,
          page: postLikedUsersBloc.currentPage + 1,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              sl<PostLikedUsersBloc>()
                ..add(FetchPostLikedUsers(postId: widget.userId, page: 1)),
      child: BlocBuilder<PostLikedUsersBloc, PostLikedUsersState>(
        builder: (context, state) {
          postLikedUsersBloc = context.read<PostLikedUsersBloc>();

          if (state is PostLikedUsersLoading &&
              state is! PostLikedUsersLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PostLikedUsersError) {
            return Center(child: Text("Error: ${state.message}"));
          }

          if (state is PostLikedUsersLoaded ||
              state is PostLikedUsersLoadedWithMore) {
            final followers =
                state is PostLikedUsersLoadedWithMore
                    ? state.followers
                    : (state as PostLikedUsersLoaded).followers;

            return Scaffold(
              appBar: AppBar(title: const Text("Post Likes")),
              body: ListView.separated(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 20,
                ), // Outer padding for list
                itemCount:
                    followers.length +
                    (state is PostLikedUsersLoadingMore ? 1 : 0),
                separatorBuilder:
                    (context, index) =>
                        const SizedBox(height: 8), // Space between items
                itemBuilder: (context, index) {
                  if (index < followers.length) {
                    final user = followers[index];
                    return UserTile(user: user);
                  } else {
                    return const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                      ), // Padding around loader
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            );
          }

          return const Center(child: Text("No followers available."));
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }
}
