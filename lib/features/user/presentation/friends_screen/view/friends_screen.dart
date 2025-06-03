import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/features/user/presentation/friends_screen/bloc/friends_bloc.dart';
import 'package:tafaling/features/user/presentation/widgets/user_tile/user_tile.dart';
import 'package:tafaling/shared/widgets/app_custom_app_bar.dart';
import 'package:tafaling/shared/widgets/list_shimmer_skeleton.dart';

class FriendsScreen extends StatefulWidget {
  final int userId;

  const FriendsScreen({super.key, required this.userId});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Initial fetch
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FriendsBloc>().add(
        FetchFriends(userId: widget.userId, page: 1),
      );
    });

    // Infinite scroll
    _scrollController.addListener(() {
      final friendsBloc = context.read<FriendsBloc>();
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          friendsBloc.hasMoreFollowers &&
          !friendsBloc.isLoading) {
        friendsBloc.add(
          FetchFriends(
            userId: widget.userId,
            page: friendsBloc.currentPage + 1,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppBar(title: "Friends"),
      body: BlocBuilder<FriendsBloc, FriendsState>(
        builder: (context, state) {
          if (state is FriendsError) {
            return Center(child: Text("Error: ${state.message}"));
          }

          if (state is FriendsLoaded || state is FriendsLoadingMore) {
            final followers =
                state is FriendsLoaded
                    ? state.followers
                    : (state as FriendsLoadingMore).followers;

            if (followers.isEmpty) {
              return const Center(child: Text("No followers found."));
            }

            final isLoadingMore = state is FriendsLoadingMore;

            return ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: followers.length + (isLoadingMore ? 1 : 0),
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                if (index < followers.length) {
                  return UserTile(user: followers[index]);
                } else {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            );
          }

          // Initial loading skeleton
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: 6,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (_, __) => const ListShimmerSkeleton(),
          );
        },
      ),
    );
  }
}
