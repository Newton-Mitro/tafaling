import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/features/user/presentation/users_followers_screen/bloc/users_followers_bloc.dart';
import 'package:tafaling/features/user/presentation/widgets/user_tile/user_tile.dart';

class UsersFollowersScreen extends StatefulWidget {
  final int userId;

  const UsersFollowersScreen({super.key, required this.userId});

  @override
  State<UsersFollowersScreen> createState() => _UsersFollowersScreenState();
}

class _UsersFollowersScreenState extends State<UsersFollowersScreen> {
  late UserFollowersBloc _userFollowersBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _userFollowersBloc = BlocProvider.of<UserFollowersBloc>(context);
    // Fetch first page of followers
    _userFollowersBloc.add(FetchUserFollowers(userId: widget.userId, page: 1));

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      final state = _userFollowersBloc.state;

      if (_userFollowersBloc.hasMoreFollowers &&
          !_userFollowersBloc.isLoading) {
        final nextPage = _userFollowersBloc.currentPage + 1;

        _userFollowersBloc.add(
          FetchUserFollowers(userId: widget.userId, page: nextPage),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserFollowersBloc, UserFollowersState>(
        builder: (context, state) {
          if (state is UserFollowersLoading && state is! UserFollowersLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is UserFollowersError) {
            return Center(child: Text("Error: ${state.message}"));
          }

          if (state is UserFollowersLoaded ||
              state is UserFollowersErrorWithMore ||
              state is UserFollowersLoadingMore) {
            final followers =
                (state is UserFollowersLoaded)
                    ? state.followers
                    : (state as dynamic).followers;

            final isLoadingMore = state is UserFollowersLoadingMore;

            return ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              itemCount: followers.length + (isLoadingMore ? 1 : 0),
              separatorBuilder: (_, __) => const SizedBox(height: 8),
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
