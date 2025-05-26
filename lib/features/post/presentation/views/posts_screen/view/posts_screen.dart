import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/features/post/presentation/widgets/post_viewer/views/post_viewer.dart';
import 'package:tafaling/features/post/presentation/views/posts_screen/bloc/posts_screen_bloc.dart';
import 'package:tafaling/shared/widgets/app_custom_app_bar.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  late PageController _pageController;
  int _lastReportedPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    context.read<PostsScreenBloc>().add(const InitPostsScreenEvent());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handlePageChanged(int index) {
    final bloc = context.read<PostsScreenBloc>();
    final state = bloc.state;

    if (index != _lastReportedPage) {
      _lastReportedPage = index;
      bloc.add(PageChangeEvent(pageIndex: index));
    }

    final isLastPage = index >= state.posts.length - 1;
    if (isLastPage && !state.isFetching) {
      bloc.add(const FetchPostsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppBar(title: "Home"),
      body: BlocBuilder<PostsScreenBloc, PostsScreenState>(
        builder: (context, state) {
          if (state.posts.isNotEmpty) {
            return PageView.builder(
              scrollDirection: Axis.vertical,
              controller: _pageController,
              itemCount: state.posts.length + (state.isFetching ? 1 : 0),
              physics: const PageScrollPhysics(),
              allowImplicitScrolling: true,
              onPageChanged: _handlePageChanged,
              itemBuilder: (context, index) {
                if (index >= state.posts.length) {
                  return const Center(child: CircularProgressIndicator());
                }

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
            );
          }

          if (state.isFetching) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error.isNotEmpty) {
            return Center(child: Text('Error: ${state.error}'));
          }

          return const Center(child: Text('No posts available'));
        },
      ),
    );
  }
}
