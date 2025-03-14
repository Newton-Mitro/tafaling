// bottom_navigation_bar.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tafaling/core/utils/app_context.dart';
import 'package:tafaling/features/home/presentation/notifier/notifiers.dart';
import 'package:tafaling/features/home/presentation/widgets/bottom_sheet.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
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
            currentIndex: selectedPage,
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              if (value > 0) {
                if (accessTokenNotifier.value != null) {
                  selectedPageNotifier.value = value;
                } else {
                  showCustomBottomSheet(context);
                }
              } else {
                selectedPageNotifier.value = value;
              }
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.house,
                ), // Icon color for Home
                label: context.appLocalizations.home,
              ),
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.peopleGroup,
                ), // Icon color for Search
                label: context.appLocalizations.friends,
              ),
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.solidNoteSticky,
                ), // Icon color for Profile
                label: context.appLocalizations.post,
              ),
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.inbox,
                ), // Icon color for Notifications
                label: context.appLocalizations.inbox,
              ),
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.circleUser,
                ), // Icon color for Settings
                label: context.appLocalizations.profile,
              ),
            ],
          ),
        );
      },
    );
  }
}
