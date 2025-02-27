// bottom_navigation_bar.dart
import 'package:flutter/material.dart';
import 'package:tafaling/core/utils/app_context.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const MyBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.colorScheme.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 5.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: 2,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        onTap: onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ), // Icon color for Home
            label: context.appLocalizations.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people,
            ), // Icon color for Search
            label: context.appLocalizations.friends,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.post_add,
            ), // Icon color for Profile
            label: context.appLocalizations.post,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
            ), // Icon color for Notifications
            label: context.appLocalizations.inbox,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_rounded,
            ), // Icon color for Settings
            label: context.appLocalizations.profile,
          ),
        ],
      ),
    );
  }
}
