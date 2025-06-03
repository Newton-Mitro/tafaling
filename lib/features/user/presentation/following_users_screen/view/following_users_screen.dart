import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/features/user/presentation/following_users_screen/bloc/following_users_bloc.dart';
import 'package:tafaling/features/user/presentation/widgets/user_tile/user_tile.dart';

class FollowingUsersScreen extends StatefulWidget {
  final int userId;

  const FollowingUsersScreen({super.key, required this.userId});

  @override
  State<FollowingUsersScreen> createState() => _FollowingUsersScreenState();
}

class _FollowingUsersScreenState extends State<FollowingUsersScreen> {
  late FollowingUsersBloc _followingUsersBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _followingUsersBloc = BlocProvider.of<FollowingUsersBloc>(context);
    // Fetch first page of following users
    _followingUsersBloc.add(
      FetchFollowingUsers(userId: widget.userId, page: 1),
    );

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      final state = _followingUsersBloc.state;

      // Only fetch more if hasMoreFollowers and not currently loading
      if (_followingUsersBloc.hasMoreFollowers &&
          state is! FollowingUsersLoadingMore &&
          state is! FollowingUsersLoading) {
        // Increment page to load next page
        final nextPage = _followingUsersBloc.currentPage + 1;

        _followingUsersBloc.add(
          FetchFollowingUsers(userId: widget.userId, page: nextPage),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FollowingUsersBloc, FollowingUsersState>(
        builder: (context, state) {
          if (state is FollowingUsersLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FollowingUsersError) {
            return Center(child: Text("Error: ${state.message}"));
          }

          if (state is FollowingUsersLoaded ||
              state is FollowingUsersErrorWithMore) {
            final followers =
                state is FollowingUsersLoaded
                    ? state.followers
                    : (state as FollowingUsersErrorWithMore).followers;

            final isLoadingMore =
                _followingUsersBloc.state is FollowingUsersLoadingMore;

            return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                // Optionally trigger _onScroll here too for redundancy
                if (scrollNotification is ScrollUpdateNotification) {
                  _onScroll();
                }
                return false;
              },
              child: ListView.separated(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 20,
                ),
                itemCount: followers.length + (isLoadingMore ? 1 : 0),
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  if (index < followers.length) {
                    final user = followers[index];
                    return UserTile(user: user);
                  } else {
                    // Loading more indicator at bottom
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    );
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
    _scrollController.dispose();
    super.dispose();
  }
}
