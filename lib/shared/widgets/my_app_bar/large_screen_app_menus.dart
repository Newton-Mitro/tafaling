import 'package:flutter/material.dart';
import 'package:flutter_skeleton/constants/app_menu_list.dart';
import 'package:flutter_skeleton/shared/widgets/my_app_bar/large_screen_app_menu_item.dart';
import 'package:flutter_skeleton/utils/app_context.dart';

class LargeScreenAppMenus extends StatelessWidget {
  const LargeScreenAppMenus({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: context.appDimensions.appBarSpacing,
      children: AppMenuList.getMenus(context)
          .map((menu) => LargeScreenAppMenuItem(menu: menu))
          .toList(),
    );
  }
}
