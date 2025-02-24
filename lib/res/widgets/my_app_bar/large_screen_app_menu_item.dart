import 'package:flutter/material.dart';
import 'package:flutter_skeleton/res/values/constants/app_menu_list.dart';
import 'package:flutter_skeleton/core/utils/app_context.dart';

class LargeScreenAppMenuItem extends StatelessWidget {
  const LargeScreenAppMenuItem({super.key, required this.menu});

  final AppMenuModel menu;

  @override
  Widget build(BuildContext context) {
    return Text(
      menu.title,
      style: context.textStyle.appBarTextStyle,
    );
  }
}
