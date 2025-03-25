import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/features/home/presentation/notifier/notifiers.dart';
import 'package:tafaling/features/post/presentation/views/post_preview_screen/views/post_viewer.dart';
import 'package:tafaling/features/post/presentation/views/post_preview_screen/widgets/post_top_navigation.dart';
import 'package:tafaling/features/post/presentation/views/posts_screen/bloc/posts_screen_bloc.dart';

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
                    if (state.posts[index].shareDetails.isNotEmpty) {
                      return PostViewer(
                        postModel: state.posts[index].shareDetails[0],
                        sharedBy: state.posts[index].creator,
                      );
                    } else {
                      return PostViewer(postModel: state.posts[index]);
                    }
                  },
                ),
                if (accessTokenNotifier.value != null) PostTopNavigation(),
              ],
            );
          }

          return const Stack(
            children: [Center(child: CircularProgressIndicator())],
          );
        },
      ),
    );
  }
}
