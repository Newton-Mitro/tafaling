import 'package:flutter/material.dart';
import 'package:tafaling/features/home/presentation/states/notifiers.dart';
import 'package:tafaling/features/post/data/data_sources/temp_posts_data.dart';
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
          return Stack(
            children: [
              PageView.builder(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                controller: _pageController,
                itemCount: posts.length,
                onPageChanged: (index) {
                  selectedPostNotifier.value = index;
                },
                itemBuilder: (context, index) {
                  return PostViewer(
                    postModel: posts[index],
                  );
                },
              ),
              PostTopNavigation(),
            ],
          );
        },
      ),
    );
  }
}
