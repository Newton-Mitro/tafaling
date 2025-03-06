import 'package:flutter/material.dart';
import 'package:tafaling/core/widgets/my_bottom_navigation_bar/states/notifiers.dart';
import 'package:tafaling/features/post/presentation/widgets/post_viewer.dart';
import 'package:tafaling/features/post/presentation/widgets/top_navigation.dart';

class PostsViewer extends StatefulWidget {
  const PostsViewer({super.key});

  @override
  State<PostsViewer> createState() => _PostsViewerState();
}

class _PostsViewerState extends State<PostsViewer> {
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
    return ValueListenableBuilder(
      valueListenable: selectedPostNotifier,
      builder: (context, selectedPost, child) {
        return Stack(
          children: [
            PageView.builder(
              scrollDirection: Axis.vertical,
              controller: _pageController,
              itemCount: 10,
              onPageChanged: (index) {
                selectedPostNotifier.value = index;
              },
              itemBuilder: (context, index) {
                return Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    PostViewer(
                      imageUrl:
                          'https://img.freepik.com/premium-photo/portrait-beautiful-young-woman-traditional-costume_762026-53741.jpg',
                    ),
                    Text(
                      "$selectedPost",
                      style: TextStyle(fontSize: 50, color: Colors.purple),
                    ),
                  ],
                );
              },
            ),
            TopNavigation(),
          ],
        );
      },
    );
  }
}
