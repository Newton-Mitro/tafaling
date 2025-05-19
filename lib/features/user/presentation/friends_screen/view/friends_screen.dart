import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/injection.dart';
import 'package:tafaling/features/user/presentation/friends_screen/bloc/friends_bloc.dart';
import 'package:tafaling/features/user/presentation/widgets/user_tile/user_tile.dart';

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

    /// Delay bloc access until the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final friendsBloc = context.read<FriendsBloc>();
      friendsBloc.add(FetchFriends(userId: widget.userId, page: 1));
    });

    /// Pagination logic: Load more when reaching the bottom
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        final friendsBloc = context.read<FriendsBloc>();
        if (friendsBloc.hasMoreFollowers) {
          friendsBloc.add(
            FetchFriends(
              userId: widget.userId,
              page: friendsBloc.currentPage + 1,
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Friends")),
      body: BlocBuilder<FriendsBloc, FriendsState>(
        builder: (context, state) {
          if (state is FriendsLoading && state is! FriendsLoaded) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is FriendsError) {
            return Center(child: Text("Error: ${state.message}"));
          }

          if (state is FriendsLoaded || state is FriendsLoadedWithMore) {
            final followers =
                state is FriendsLoadedWithMore
                    ? state.followers
                    : (state as FriendsLoaded).followers;

            if (followers.isEmpty) {
              return Center(child: Text("No followers found."));
            } else {
              return ListView.builder(
                controller: _scrollController,
                itemCount: followers.length,
                itemBuilder: (context, index) {
                  final user = followers[index];
                  return UserTile(user: user);
                },
              );
            }
          }
          return Center(child: Text("No followers found."));
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
