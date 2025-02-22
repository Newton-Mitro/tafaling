import 'package:flutter/material.dart';
import 'package:flutter_skeleton/shared/widgets/app_bar_drawer_icon.dart';
import 'package:flutter_skeleton/utils/app_context.dart';

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
                if (context.isDesktop) AppLargeMenus(),
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

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      context.appLocalizations.appName,
      style: context.textStyle.appBarTextStyle,
    );
  }
}

class AppLargeMenus extends StatelessWidget {
  const AppLargeMenus({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: context.appDimensions.appBarSpacing,
      children: [
        Text(context.appLocalizations.home),
        Text(context.appLocalizations.about),
        Text(context.appLocalizations.contact),
      ],
    );
  }
}

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(itemBuilder: (context) {
      return [
        PopupMenuItem(child: const Text('English')),
        PopupMenuItem(child: const Text('বাংলা')),
      ];
    });
  }
}

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Switch(value: false, onChanged: (value) {});
  }
}
