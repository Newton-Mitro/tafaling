import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/features/post/presentation/views/post_preview_screen/views/post_viewer.dart';
import 'package:tafaling/features/post/presentation/views/posts_screen/bloc/posts_screen_bloc.dart';
import 'package:tafaling/routes/route_name.dart';
import 'package:tafaling/shared/widgets/language_switch/language_switch.dart';
import 'package:tafaling/shared/widgets/theme_selector/theme_selector.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: context.read<PostsScreenBloc>().state.currentPage,
    );
    context.read<PostsScreenBloc>().add(FetchPostsEvent());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        elevation: 5,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.searchUser);
            },
          ),
          ThemeSelector(),
          LanguageSwitch(),
          PopupMenuButton<int>(
            offset: const Offset(0, 52),
            icon: Icon(Icons.more_vert), // ← use this instead of child
            onSelected: (value) async {
              if (value == 0) {
                debugPrint('Profile tapped');
              } else if (value == 1) {
                debugPrint('Settings tapped');
              } else if (value == 2) {
                debugPrint('Logout tapped');
              }
            },
            itemBuilder:
                (context) => [
                  const PopupMenuItem(
                    value: 0,
                    child: Row(
                      children: [
                        Icon(Icons.person, size: 20),
                        SizedBox(width: 8),
                        Text('Profile'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        Icon(Icons.settings, size: 20),
                        SizedBox(width: 8),
                        Text('Settings'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    enabled: false,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1.2,
                      height: 8,
                    ),
                  ),
                  const PopupMenuItem(
                    value: 2,
                    child: Row(
                      children: [
                        Icon(Icons.logout, size: 20),
                        SizedBox(width: 8),
                        Text('Logout'),
                      ],
                    ),
                  ),
                ],
          ),
        ],
      ),
      body: BlocBuilder<PostsScreenBloc, PostsScreenState>(
        builder: (context, state) {
          if (state.posts.isNotEmpty) {
            return Stack(
              children: [
                PageView.builder(
                  scrollDirection: Axis.vertical,
                  controller: _pageController,
                  itemCount: state.posts.length,
                  physics: const PageScrollPhysics(),
                  allowImplicitScrolling: true,
                  onPageChanged: (index) {
                    if (index == state.posts.length - 1 && !state.isFetching) {
                      context.read<PostsScreenBloc>().add(
                        const FetchPostsEvent(),
                      );
                    }
                    context.read<PostsScreenBloc>().add(
                      PageChangeEvent(currentPage: index),
                    );
                  },
                  itemBuilder: (context, index) {
                    final post = state.posts[index];
                    if (post.shareDetails.isNotEmpty) {
                      return PostViewer(
                        postModel: post.shareDetails[0],
                        sharedBy: post.creator,
                      );
                    } else {
                      return PostViewer(postModel: post);
                    }
                  },
                ),
              ],
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
