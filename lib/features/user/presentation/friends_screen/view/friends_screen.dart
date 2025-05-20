import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/features/user/presentation/friends_screen/bloc/friends_bloc.dart';
import 'package:tafaling/features/user/presentation/widgets/user_tile/user_tile.dart';
import 'package:tafaling/routes/route_name.dart';
import 'package:tafaling/shared/widgets/language_switch/language_switch.dart';
import 'package:tafaling/shared/widgets/theme_selector/theme_selector.dart';

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
      final friendsBloc = context.read<FriendsBloc>();
      friendsBloc.add(FetchFriends(userId: widget.userId, page: 1));
    });

    // Infinite scroll logic
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Friends'),
        elevation: 5,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.searchUser);
            },
          ),
          const ThemeSelector(),
          const LanguageSwitch(),
          const SizedBox(width: 10),
        ],
      ),
      body: BlocBuilder<FriendsBloc, FriendsState>(
        builder: (context, state) {
          if (state is FriendsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

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

            return ListView.builder(
              controller: _scrollController,
              itemCount: followers.length + (isLoadingMore ? 1 : 0),
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

          return const Center(child: Text("No followers found."));
        },
      ),
    );
  }
}
