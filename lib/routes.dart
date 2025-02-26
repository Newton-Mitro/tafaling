import 'package:flutter/material.dart';
import 'package:flutter_skeleton/core/constants/route_name.dart';
import 'package:flutter_skeleton/features/home/presentation/pages/home_page.dart';
import 'package:flutter_skeleton/features/splash/presentation/pages/splash_screen.dart';

class AppRoutes {
  Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case RoutesName.homeScreen:
        return _materialRoute(const HomePage());

      case RoutesName.splashScreen:
        return _materialRoute(const SplashScreen());

      default:
        return _materialRoute(const HomePage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
