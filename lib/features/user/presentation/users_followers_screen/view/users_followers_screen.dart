import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/features/user/presentation/users_followers_screen/bloc/users_followers_bloc.dart';
import 'package:tafaling/features/user/presentation/widgets/user_tile.dart';

class UsersFollowersScreen extends StatefulWidget {
  final int userId;

  const UsersFollowersScreen({super.key, required this.userId});

  @override
  State<UsersFollowersScreen> createState() => _UsersFollowersScreenState();
}

class _UsersFollowersScreenState extends State<UsersFollowersScreen> {
  late UserFollowersBloc userFollowersBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    userFollowersBloc = BlocProvider.of<UserFollowersBloc>(context);
    userFollowersBloc.add(FetchUserFollowers(userId: widget.userId, page: 1));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (userFollowersBloc.hasMoreFollowers) {
          userFollowersBloc.add(
            FetchUserFollowers(
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
      body: BlocBuilder<UserFollowersBloc, UserFollowersState>(
        builder: (context, state) {
          if (state is UserFollowersLoading && state is! UserFollowersLoaded) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is UserFollowersError) {
            return Center(child: Text("Error: ${state.message}"));
          }

          if (state is UserFollowersLoaded ||
              state is UserFollowersLoadedWithMore) {
            final followers =
                state is UserFollowersLoadedWithMore
                    ? (state as UserFollowersLoadedWithMore).followers
                    : (state as UserFollowersLoaded).followers;

            return ListView.builder(
              controller: _scrollController,
              itemCount:
                  followers.length +
                  (state is UserFollowersLoadingMore ? 1 : 0),
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
