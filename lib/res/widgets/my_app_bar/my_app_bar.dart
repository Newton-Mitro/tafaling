import 'package:flutter/material.dart';
import 'package:flutter_skeleton/res/widgets/app_logo.dart';
import 'package:flutter_skeleton/res/widgets/language_selector/language_selector.dart';
import 'package:flutter_skeleton/res/widgets/my_app_bar/app_bar_drawer_icon.dart';
import 'package:flutter_skeleton/res/widgets/my_app_bar/large_screen_app_menus.dart';
import 'package:flutter_skeleton/res/widgets/theme_switcher/theme_switcher.dart';
import 'package:flutter_skeleton/core/utils/app_context.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      alignment: Alignment.center,
      color: context.theme.appBarTheme.backgroundColor,
      height: context.appDimensions.appBarHeight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: context.appDimensions.containerWidth,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: context.appDimensions.appBarSpacing,
              children: [
                AppLogo(),
                if (context.isDesktop) LargeScreenAppMenus(),
              ],
            ),
            Row(
              children: [
                LanguageSelector(),
                ThemeSwitcher(),
                if (!context.isDesktop) AppBarDrawerIcon(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
