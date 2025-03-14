import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/features/home/presentation/notifier/notifiers.dart';
import 'package:tafaling/features/post/presentation/posts_screen/bloc/posts_screen_bloc.dart';
import 'package:tafaling/features/post/presentation/widgets/post_viewer.dart';
import 'package:tafaling/features/post/presentation/widgets/post_top_navigation.dart';

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
    _pageController = PageController(initialPage: selectedPostNotifier.value);
    context.read<PostsScreenBloc>().add(const FetchPostsEvent());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: selectedPostNotifier,
        builder: (context, selectedPost, child) {
          return BlocBuilder<PostsScreenBloc, PostsScreenState>(
            builder: (context, state) {
              if (state.posts.isNotEmpty) {
                return Stack(
                  children: [
                    PageView.builder(
                      scrollDirection: Axis.vertical,
                      controller: _pageController,
                      itemCount: state.posts.length,
                      allowImplicitScrolling: true,
                      onPageChanged: (index) {
                        selectedPostNotifier.value = index;
                      },
                      itemBuilder: (context, index) {
                        return PostViewer(
                          postModel: state.posts[index],
                        );
                      },
                    ),
                    if (accessTokenNotifier.value != null) PostTopNavigation(),
                  ],
                );
              }

              return const Stack(
                children: [
                  // Page content (empty for now while fetching)
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
