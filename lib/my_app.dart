import 'package:flutter/material.dart';
import 'package:tafaling/features/home/presentation/home_screen/view/home_screen.dart';
import 'package:tafaling/features/onboarding/presentation/views/onboarding_screen.dart';
import 'package:tafaling/app_configs/themes/app_theme.dart';
import 'package:tafaling/core/widgets/theme_switcher/bloc/theme_bloc.dart';
import 'package:tafaling/core/utils/app_context.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final bool onBoarding;
  const MyApp({super.key, required this.onBoarding});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeBloc, ThemeState>(
      listener: (context, state) {},
      builder: (context, themeState) {
        return MaterialApp(
          title: context.appLocalizations.appName,
          debugShowCheckedModeBanner: false,
          darkTheme: AppTheme().dark,
          theme: AppTheme().light,
          navigatorKey: navigatorKey,
          themeMode:
              themeState is LightThemeState ? ThemeMode.dark : ThemeMode.dark,
          home: onBoarding ? OnboardingScreen() : HomeScreen(),
          onGenerateRoute: AppRoutes().onGenerateRoutes,
        );
      },
    );
  }
}
