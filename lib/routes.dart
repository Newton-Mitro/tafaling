import 'package:flutter/material.dart';
import 'package:tafaling/configs/routes/route_name.dart';
import 'package:tafaling/features/auth/presentation/views/login_screen.dart';
import 'package:tafaling/features/auth/presentation/views/register_screen.dart';
import 'package:tafaling/features/home/presentation/home_screen/view/home_screen.dart';
import 'package:tafaling/features/post/presentation/post_liked_users_screen/view/post_liked_users_screen.dart';
import 'package:tafaling/features/user/presentation/search_screen/view/search_screen.dart';
import 'package:tafaling/features/user/presentation/user_profile_screen/view/user_profile_screen.dart';

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

      case RoutesName.postLikedUsersPage:
        return _materialRoute(PostLikedUsersScreen(userId: args));

      default:
        return _materialRoute(const HomeScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
