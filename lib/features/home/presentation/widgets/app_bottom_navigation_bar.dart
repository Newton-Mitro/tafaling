import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tafaling/core/utils/app_context.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.theme.colorScheme.primary,
            context.theme.colorScheme.primary,
          ],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 1.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {},
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house), // Icon color for Home
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.peopleGroup), // Icon color for Search
            label: "Friends",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.solidNoteSticky,
            ), // Icon color for Profile
            label: "Posts",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.inbox,
            ), // Icon color for Notifications
            label: "Inbox",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.circleUser,
            ), // Icon color for Settings
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
