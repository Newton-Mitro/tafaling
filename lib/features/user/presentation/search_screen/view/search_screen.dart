import 'dart:async'; // Import for Timer
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/configs/routes/route_name.dart';
import 'package:tafaling/features/user/presentation/search_screen/bloc/search_screen_bloc.dart';
import 'package:tafaling/features/user/presentation/widgets/user_tile.dart';
import 'package:tafaling/injection_container.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late SearchScreenBloc _searchBloc;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchBloc = serviceLoc<SearchScreenBloc>();
  }

  void _onSearch(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        _searchBloc.add(SearchUsersEvent(query));
      } else {
        _searchBloc.add(ResetSearchEvent());
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    _searchBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _searchBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              height: 40,
              child: TextField(
                controller: _searchController,
                onChanged: _onSearch,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: const Icon(Icons.search, color: Colors.white70),
                  hintText: 'Search users',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                    height: 1, // Ensures vertical centering
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10), // Centers the text vertically
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
                        child: Text('Start typing to search...'));
                  } else if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchLoaded) {
                    final users = state.users;

                    return ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
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
                      child: Text(state.message,
                          style: const TextStyle(color: Colors.red)),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
