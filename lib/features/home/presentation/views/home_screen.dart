import 'package:flutter/material.dart';
import 'package:tafaling/features/home/presentation/widgets/bottom_sheet.dart';
import 'package:tafaling/features/home/presentation/widgets/my_bottom_navigation_bar.dart';
import 'package:tafaling/features/home/presentation/states/notifiers.dart';
import 'package:tafaling/features/home/presentation/views/friends_screen.dart';
import 'package:tafaling/features/home/presentation/views/inbox_screen.dart';
import 'package:tafaling/features/home/presentation/views/post_screen.dart';
import 'package:tafaling/features/post/presentation/views/posts_screen.dart';
import 'package:tafaling/features/user/presentation/views/my_profile_screen.dart';

List<Widget> screens = [
  PostsScreen(),
  FriendsScreen(),
  PostScreen(),
  InboxScreen(),
  MyProfileScreen(),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          // Ensure Bottom Sheet logic runs after the frame is built
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (bottomSheetToggleNotifier.value == true) {
              BottomSheetHelper.showCustomBottomSheet(
                  context, MediaQuery.of(context).size);
            }
          });
          return screens.elementAt(selectedPage);
        },
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}
