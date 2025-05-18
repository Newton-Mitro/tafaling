import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/injection.dart';
import 'package:tafaling/features/post/presentation/views/post_liked_users_screen/bloc/post_liked_users_bloc.dart';
import 'package:tafaling/features/user/presentation/widgets/user_tile/user_tile.dart';

class PostLikedUsersScreen extends StatefulWidget {
  final Object? userId; // Change Object? to int directly

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
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (postLikedUsersBloc.hasMoreFollowers) {
        postLikedUsersBloc.add(
          FetchPostLikedUsers(
            postId: widget.userId as int,
            page: postLikedUsersBloc.currentPage + 1,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              sl<PostLikedUsersBloc>()..add(
                FetchPostLikedUsers(postId: widget.userId as int, page: 1),
              ),
      child: BlocBuilder<PostLikedUsersBloc, PostLikedUsersState>(
        builder: (context, state) {
          postLikedUsersBloc =
              context
                  .read<
                    PostLikedUsersBloc
                  >(); // Get bloc instance after provider is created

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
              appBar: AppBar(title: Text("Post Likes")),
              body: ListView.builder(
                controller: _scrollController,
                itemCount:
                    followers.length +
                    (state is PostLikedUsersLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < followers.length) {
                    final user = followers[index];
                    return UserTile(user: user);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            );
          }

          return const Center(child: Text("No followers available"));
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
