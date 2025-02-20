import 'package:flutter/material.dart';
import 'package:flutter_skeleton/utils/app_context.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 20,
          children: [
            AppLogo(),
            AppLargeMenus(),
          ],
        ),
        Row(
          children: [
            LanguageSelector(),
            ThemeSwitcher(),
          ],
        ),
      ],
    );
  }
}

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      context.stringResource.appName,
      style: context.textStyle.appBarTextStyle,
    );
  }
}

class AppLargeMenus extends StatelessWidget {
  const AppLargeMenus({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 20,
      children: [
        Text(context.stringResource.home),
        Text(context.stringResource.about),
        Text(context.stringResource.contact),
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
