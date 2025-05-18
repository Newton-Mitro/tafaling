import 'package:flutter/material.dart';
import 'package:tafaling/features/home/presentation/home_screen/view/home_screen.dart';
import 'package:tafaling/features/onboarding/presentation/views/onboarding_screen.dart';
import 'package:tafaling/core/theme/app_theme.dart';
import 'package:tafaling/core/utils/app_context.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/routes.dart';
import 'package:tafaling/shared/widgets/theme_selector/bloc/theme_selector_bloc.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final bool onBoarding;
  const MyApp({super.key, required this.onBoarding});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeSelectorBloc, ThemeSelectorState>(
      listener: (context, state) {},
      builder: (context, themeState) {
        return MaterialApp(
          title: "App Name",
          debugShowCheckedModeBanner: false,
          theme: themeState.themeData,
          navigatorKey: navigatorKey,
          home: onBoarding ? OnboardingScreen() : HomeScreen(),
          onGenerateRoute: AppRoutes().onGenerateRoutes,
        );
      },
    );
  }
}
