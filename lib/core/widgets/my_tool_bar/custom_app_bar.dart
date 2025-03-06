import 'package:flutter/material.dart';
import 'package:tafaling/core/utils/app_context.dart';
import 'package:tafaling/core/widgets/language_selector/language_selector.dart';
import 'package:tafaling/core/widgets/my_app_bar/app_bar_drawer_icon.dart';
import 'package:tafaling/core/widgets/theme_switcher/theme_switcher.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(60); // Adjust the height as needed

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        // decoration: BoxDecoration(
        //   color: context.theme.appBarTheme.backgroundColor,
        //   // gradient: LinearGradient(
        //   //   colors: [Colors.blue, Colors.purple], // Gradient colors
        //   //   begin: Alignment.topLeft,
        //   //   end: Alignment.bottomRight,
        //   // ),
        //   boxShadow: [
        //     BoxShadow(
        //       color: Colors.black26,
        //       blurRadius: 4,
        //       offset: Offset(0, 2),
        //     ),
        //   ],
        // ),
        child: AppBar(
          title: Text(
            context.appLocalizations.appName,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0, // Remove default shadow
          actions: [
            LanguageSelector(),
            ThemeSwitcher(),
            PopupMenuButton(itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: "settings",
                  child: Text("Settings"),
                ),
                PopupMenuItem(
                  value: "logout",
                  child: Text("Logout"),
                ),
              ];
            }),
          ],
        ),
      ),
    );
  }
}
