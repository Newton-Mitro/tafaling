import 'package:flutter/material.dart';
import 'package:tafaling/configs/routes/route_name.dart';
import 'package:tafaling/features/auth/presentation/views/login_screen.dart';
import 'package:tafaling/features/auth/presentation/views/register_screen.dart';
import 'package:tafaling/features/home/presentation/views/home_screen.dart';
import 'package:tafaling/features/user/presentation/views/search_screen.dart';
import 'package:tafaling/features/user/presentation/views/user_profile_screen.dart';

class AppRoutes {
  Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case RoutesName.homePage:
        return _materialRoute(const HomeScreen());

      case RoutesName.loginPage:
        return _materialRoute(const LoginScreen());

      case RoutesName.registerPage:
        return _materialRoute(const RegistrationScreen());

      case RoutesName.userProfilePage:
        return _materialRoute(UserProfileScreen(userId: args));

      case RoutesName.searchUser:
        return _materialRoute(SearchScreen());

      default:
        return _materialRoute(const HomeScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
