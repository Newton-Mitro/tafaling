import 'dart:async'; // Import for Timer

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/configs/routes/route_name.dart';
import 'package:tafaling/features/user/presentation/states/user_search_bloc/search_screen_bloc.dart';
import 'package:tafaling/features/user/presentation/widgets/user_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late SearchScreenBloc _searchBloc;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchBloc = BlocProvider.of<SearchScreenBloc>(context);
  }

  void _onSearch(String query) {
    // Cancel the previous timer if it exists
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    // Start a new timer to wait for 1 second before making the search request
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        print("Sending SearchUsersEvent: $query");
        _searchBloc.add(SearchUsersEvent(query));
      } else {
        _searchBloc.add(ResetSearchEvent());
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel(); // Cancel debounce when disposing
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 41, 41),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 2, 37, 39),
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            child: TextField(
              controller: _searchController,
              onChanged: _onSearch, // Call _onSearch when text changes
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 39, 51, 51),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                hintText: 'Search users',
                hintStyle: const TextStyle(color: Colors.white60),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<SearchScreenBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchInitial) {
                  return const Center(
                    child: Text(
                      'Start typing to search...',
                      style: TextStyle(color: Colors.white70),
                    ),
                  );
                } else if (state is SearchLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchLoaded) {
                  final users = state.users;

                  return ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: users.length + 1, // For loading indicator
                    itemBuilder: (context, index) {
                      if (index == users.length) {
                        return state is SearchLoading
                            ? const Center(child: CircularProgressIndicator())
                            : const SizedBox.shrink();
                      }

                      final user = users[index];
                      return UserTile(
                        userAvatar: user.profilePicture ?? '',
                        userName: user.name,
                        isFollowing: user.isFollowing,
                        friendshipStatus: 2,
                        onFollowToggle: () {
                          context
                              .read<SearchScreenBloc>()
                              .add(FollowUserEvent(user.userId));
                        },
                        onFriendRequestToggle: () {
                          context
                              .read<SearchScreenBloc>()
                              .add(UnFollowUserEvent(user.userId));
                        },
                        onViewProfile: () {
                          Navigator.pushNamed(
                            context,
                            RoutesName.userProfilePage,
                            arguments: user.userId,
                          );
                        },
                      );
                    },
                  );
                } else if (state is SearchError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
