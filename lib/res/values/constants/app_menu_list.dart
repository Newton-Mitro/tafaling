import 'package:flutter/material.dart';
import 'package:flutter_skeleton/res/values/constants/app_route.dart';
import 'package:flutter_skeleton/core/utils/app_context.dart';

class AppMenuModel {
  final String title;
  final IconData icon;
  final String route;

  AppMenuModel({
    required this.title,
    required this.icon,
    required this.route,
  });
}

class AppMenuList {
  static List<AppMenuModel> getMenus(BuildContext context) => [
        AppMenuModel(
            title: context.appLocalizations.home,
            icon: Icons.home,
            route: AppRoute.home),
        AppMenuModel(
            title: context.appLocalizations.about,
            icon: Icons.info,
            route: AppRoute.about),
        AppMenuModel(
            title: context.appLocalizations.contact,
            icon: Icons.contact_mail,
            route: AppRoute.contact),
      ];
}
