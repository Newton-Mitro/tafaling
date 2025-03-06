import 'package:flutter/material.dart';
import 'package:tafaling/core/widgets/my_bottom_navigation_bar/my_bottom_navigation_bar.dart';
import 'package:tafaling/core/widgets/my_bottom_navigation_bar/states/notifiers.dart';
import 'package:tafaling/features/home/presentation/views/friends_screen.dart';
import 'package:tafaling/features/home/presentation/views/inbox_screen.dart';
import 'package:tafaling/features/home/presentation/views/post_screen.dart';
import 'package:tafaling/features/home/presentation/views/profile_screen.dart';
import 'package:tafaling/features/post/presentation/widgets/posts_viewer.dart';

List<Widget> screens = [
  PostsViewer(),
  FriendsScreen(),
  PostScreen(),
  InboxScreen(),
  ProfileScreen(),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return screens.elementAt(selectedPage);
        },
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}
