import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/injection.dart';
import 'package:tafaling/features/auth/presentation/views/bloc/auth_bloc/auth_bloc.dart';
import 'package:tafaling/features/user/presentation/search_screen/bloc/search_screen_bloc.dart';
import 'package:tafaling/features/user/presentation/widgets/user_tile/user_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late final SearchScreenBloc _searchBloc;
  Timer? _debounce;
  String _lastQuery = '';

  int _currentUserId = 0;

  @override
  void initState() {
    super.initState();
    _searchBloc = sl<SearchScreenBloc>();

    final authState = context.read<AuthBloc>().state;
    if (authState is Authenticated) {
      _currentUserId = authState.authUser.user.id;
    }
  }

  void _onSearch(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        _lastQuery = query;
        _searchBloc.add(
          SearchUsersEvent(
            searchText: query,
            userId: _currentUserId,
            isInitialLoad: true,
          ),
        );
      } else {
        _searchBloc.add(ResetSearchEvent());
      }
    });
  }

  void _loadMore() {
    _searchBloc.add(
      SearchUsersEvent(
        searchText: _lastQuery,
        userId: _currentUserId,
        isInitialLoad: false,
      ),
    );
  }

  bool _onScrollNotification(ScrollNotification notification) {
    if (notification.metrics.pixels >=
        notification.metrics.maxScrollExtent - 100) {
      _loadMore();
    }
    return false;
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
              height: 40, // Slightly taller for better tap target
              child: TextField(
                controller: _searchController,
                onChanged: _onSearch,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white10,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 12,
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
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: BlocBuilder<SearchScreenBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchInitial) {
              return const Center(child: Text('Start typing to search...'));
            } else if (state is SearchLoading &&
                _searchBloc.state is! SearchLoaded) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SearchLoaded) {
              final users = state.users;

              if (users.isEmpty) {
                return const Center(child: Text('No users found.'));
              }

              return NotificationListener<ScrollNotification>(
                onNotification: _onScrollNotification,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  itemCount: users.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return UserTile(user: user);
                  },
                ),
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
    );
  }
}
