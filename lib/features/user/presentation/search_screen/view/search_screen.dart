import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/features/post/injection.dart';
import 'package:tafaling/features/user/presentation/search_screen/bloc/search_screen_bloc.dart';
import 'package:tafaling/features/user/presentation/widgets/user_tile/user_tile.dart';

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
    _searchBloc = sl<SearchScreenBloc>();
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
              height: 36, // Reduce the height of the TextField
              child: TextField(
                controller: _searchController,
                onChanged: _onSearch,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white10, // Light background
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 8, // Reduce vertical padding
                    horizontal: 12, // Adjust horizontal padding
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white70,
                    size: 20,
                  ),
                  hintText: 'Search users',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0), // Smaller radius
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
                      child: Text('Start typing to search...'),
                    );
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
                          user: user, // Todo:
                          // onFollowToggle: () {
                          //   context.read<SearchScreenBloc>().add(
                          //     FollowUserEvent(user.id),
                          //   );
                          // },
                          // onFriendRequestToggle: () {
                          //   context.read<SearchScreenBloc>().add(
                          //     UnFollowUserEvent(user.id),
                          //   );
                          // },
                          // onViewProfile: () {
                          //   Navigator.pushNamed(
                          //     context,
                          //     RoutesName.userProfilePage,
                          //     arguments: user.id,
                          //   );
                          // },
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
      ),
    );
  }
}
