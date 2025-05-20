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
  late FollowingUsersBloc userFollowersBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    userFollowersBloc = BlocProvider.of<FollowingUsersBloc>(context);
    userFollowersBloc.add(FetchFollowingUsers(userId: widget.userId, page: 1));

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      if (userFollowersBloc.hasMoreFollowers &&
          userFollowersBloc.state is! FollowingUsersLoadingMore &&
          userFollowersBloc.state is! FollowingUsersLoading) {
        userFollowersBloc.add(
          FetchFollowingUsers(
            userId: widget.userId,
            page: userFollowersBloc.currentPage,
          ),
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
                userFollowersBloc.state is FollowingUsersLoadingMore;

            return ListView.builder(
              controller: _scrollController,
              itemCount: followers.length + (isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < followers.length) {
                  final user = followers[index];
                  return UserTile(user: user);
                } else {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
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
