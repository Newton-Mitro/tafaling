import 'package:flutter/material.dart';
import 'package:tafaling/configs/routes/route_name.dart';
import 'package:tafaling/features/home/presentation/views/home_screen.dart';

class AppRoutes {
  Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case RoutesName.homePage:
        return _materialRoute(const HomeScreen());

      default:
        return _materialRoute(const HomeScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
