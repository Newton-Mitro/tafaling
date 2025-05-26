import 'package:flutter/material.dart';
import 'package:tafaling/core/settings/settings_privacy_page.dart';
import 'package:tafaling/features/post/domain/entities/post_entity.dart';
import 'package:tafaling/features/post/presentation/views/create_post_screen/view/create_post_attachment_screen.dart';
import 'package:tafaling/features/post/presentation/views/post_comment_screen/post_comment_screen.dart';
import 'package:tafaling/features/post/presentation/views/share_post_screen/view/share_post_screen.dart';
import 'package:tafaling/features/user/presentation/my_profile_screen/view/my_profile_screen.dart';
import 'package:tafaling/routes/app_route_name.dart';
import 'package:tafaling/features/auth/presentation/views/pages/login_screen.dart';
import 'package:tafaling/features/auth/presentation/views/pages/register_screen.dart';
import 'package:tafaling/features/home/presentation/home_screen/view/home_screen.dart';
import 'package:tafaling/features/post/presentation/views/post_liked_users_screen/view/post_liked_users_screen.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';
import 'package:tafaling/features/user/presentation/search_screen/view/search_screen.dart';
import 'package:tafaling/features/user/presentation/user_profile_screen/view/user_profile_screen.dart';

class AppRoutes {
  Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    final Object? args = settings.arguments;

    switch (settings.name) {
      case AppRouteName.homePage:
        return _materialRoute(const HomeScreen());

      case AppRouteName.loginPage:
        return _materialRoute(const LoginScreen());

      case AppRouteName.cameraPage:
        return _materialRoute(const CreatePostAttachmentScreen());

      case AppRouteName.registerPage:
        return _materialRoute(const RegistrationScreen());

      case AppRouteName.myProfilePage:
        return _materialRoute(const MyProfileScreen());

      case AppRouteName.userProfilePage:
        return _materialRoute(UserProfileScreen(user: args as UserEntity));

      case AppRouteName.searchUser:
        return _materialRoute(SearchScreen());

      case AppRouteName.postSharePage:
        return _materialRoute(SharePostScreen(postEntity: args as PostEntity));

      case AppRouteName.postCommentPage:
        return _materialRoute(
          CommentPostScreen(postEntity: args as PostEntity),
        );

      case AppRouteName.settingsPage:
        return _materialRoute(SettingsPrivacyPage());

      case AppRouteName.postLikedUsersPage:
        return _materialRoute(PostLikedUsersScreen(userId: args));

      default:
        return _materialRoute(const HomeScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
