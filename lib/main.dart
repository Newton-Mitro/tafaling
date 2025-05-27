import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:tafaling/core/injection.dart';
import 'package:tafaling/features/auth/presentation/views/bloc/auth_bloc/auth_bloc.dart';
import 'package:tafaling/features/onboarding/presentation/bloc/onboarding_page_bloc.dart';
import 'package:tafaling/features/post/presentation/views/post_comment_screen/bloc/post_comment_bloc/post_comment_bloc.dart';
import 'package:tafaling/features/post/presentation/views/post_comment_screen/bloc/post_comment_list_bloc/post_comment_list_bloc.dart';
import 'package:tafaling/features/post/presentation/views/posts_screen/bloc/posts_screen_bloc.dart';
import 'package:tafaling/features/user/presentation/following_users_screen/bloc/following_users_bloc.dart';
import 'package:tafaling/features/user/presentation/my_profile_screen/bloc/my_profile_bloc.dart';
import 'package:tafaling/features/user/presentation/user_profile_screen/bloc/profile_bloc.dart';
import 'package:tafaling/features/user/presentation/users_followers_screen/bloc/users_followers_bloc.dart';
import 'package:tafaling/injection.dart';
import 'package:tafaling/my_app.dart';
import 'package:tafaling/shared/widgets/language_switch/bloc/language_switch_bloc.dart';
import 'package:tafaling/shared/widgets/theme_selector/bloc/theme_selector_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Locales.init(['en', 'bn']);
  await setupDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<LanguageSwitchBloc>()..add(LoadLocaleEvent()),
        ),
        BlocProvider(create: (_) => sl<ThemeSelectorBloc>()..add(LoadTheme())),
        BlocProvider(create: (_) => sl<OnboardingPageBloc>()),
        BlocProvider(create: (context) => sl<PostsScreenBloc>()),
        BlocProvider(create: (context) => sl<AuthBloc>()..add(AuthUserCheck())),
        BlocProvider(create: (context) => sl<ProfileBloc>()),
        BlocProvider(create: (context) => sl<MyProfileBloc>()),
        BlocProvider(create: (context) => sl<UserFollowersBloc>()),
        BlocProvider(create: (context) => sl<FollowingUsersBloc>()),
        BlocProvider(create: (_) => sl<PostCommentListBloc>()),
        BlocProvider(create: (_) => sl<PostCommentBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}
