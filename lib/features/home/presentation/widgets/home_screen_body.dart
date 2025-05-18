import 'package:flutter/material.dart';
import 'package:tafaling/features/home/presentation/widgets/app_bottom_navigation_bar.dart';
import 'package:tafaling/features/home/presentation/home_screen/view/inbox_screen.dart';
import 'package:tafaling/features/post/presentation/views/create_post_screen/view/create_post_screen.dart';
import 'package:tafaling/features/post/presentation/views/posts_screen/view/posts_screen.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getScreen(0),
      bottomNavigationBar: const AppBottomNavigationBar(),
    );
  }

  Widget _getScreen(int selectedPage) {
    final List<Widget> screens = [
      const PostsScreen(),
      const CreatePostScreen(),
      const InboxScreen(),
    ];
    return screens[selectedPage];
  }
}
