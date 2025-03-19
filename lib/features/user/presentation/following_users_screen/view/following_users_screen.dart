import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/features/user/presentation/following_users_screen/bloc/following_users_bloc.dart';
import 'package:tafaling/features/user/presentation/widgets/user_tile.dart';

class FollowingUsersScreen extends StatefulWidget {
  final int userId;

  const FollowingUsersScreen({super.key, required this.userId});

  @override
  State<FollowingUsersScreen> createState() => _FollowingUsersScreenState();
}

class _FollowingUsersScreenState extends State<FollowingUsersScreen> {
  late FollowingUsersBloc userFollowersBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    userFollowersBloc = BlocProvider.of<FollowingUsersBloc>(context);
    userFollowersBloc.add(FetchFollowingUsers(userId: widget.userId, page: 1));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (userFollowersBloc.hasMoreFollowers) {
          userFollowersBloc.add(
            FetchFollowingUsers(
              userId: widget.userId,
              page: userFollowersBloc.currentPage + 1,
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FollowingUsersBloc, FollowingUsersState>(
        builder: (context, state) {
          if (state is FollowingUsersLoading &&
              state is! FollowingUsersLoaded) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is FollowingUsersError) {
            return Center(child: Text("Error: ${state.message}"));
          }

          if (state is FollowingUsersLoaded ||
              state is FollowingUsersLoadedWithMore) {
            final followers =
                state is FollowingUsersLoadedWithMore
                    ? (state as FollowingUsersLoadedWithMore).followers
                    : (state as FollowingUsersLoaded).followers;

            return ListView.builder(
              controller: _scrollController,
              itemCount:
                  followers.length +
                  (state is FollowingUsersLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < followers.length) {
                  final user = followers[index];
                  return UserTile(
                    user: user,
                    onFollowToggle: () {},
                    onFriendRequestToggle: () {},
                    onViewProfile: () {},
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            );
          }

          return Center(child: Text("No followers available"));
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
