import 'package:flutter/material.dart';
import 'package:tafaling/configs/routes/route_name.dart';
import 'package:tafaling/features/home/presentation/pages/home_page.dart';

class AppRoutes {
  Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case RoutesName.homeScreen:
        return _materialRoute(const HomePage());

      default:
        return _materialRoute(const HomePage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
