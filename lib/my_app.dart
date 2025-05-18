import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:tafaling/features/home/presentation/home_screen/view/home_screen.dart';
import 'package:tafaling/features/onboarding/presentation/bloc/onboarding_page_bloc.dart';
import 'package:tafaling/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:tafaling/routes.dart';
import 'package:tafaling/shared/widgets/language_switch/bloc/language_switch_bloc.dart';
import 'package:tafaling/shared/widgets/theme_selector/bloc/theme_selector_bloc.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<OnboardingPageBloc>().add(GetOnboardingSeenEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageSwitchBloc, LanguageSwitchState>(
      builder: (context, languageState) {
        return BlocBuilder<ThemeSelectorBloc, ThemeSelectorState>(
          builder: (context, themeState) {
            return BlocBuilder<OnboardingPageBloc, OnboardingPageState>(
              builder: (context, onboardingState) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  navigatorKey: navigatorKey,
                  navigatorObservers: [routeObserver],
                  theme: themeState.themeData,
                  supportedLocales: const [
                    Locale('en', 'US'),
                    Locale('bn', 'BD'),
                  ],
                  localizationsDelegates: Locales.delegates,

                  locale:
                      languageState.language == 'bn'
                          ? const Locale('bn', 'BD')
                          : const Locale('en', 'US'),
                  onGenerateRoute: AppRoutes().onGenerateRoutes,
                  initialRoute: '/',
                  home: _buildHome(onboardingState),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildHome(OnboardingPageState onboardingState) {
    if (onboardingState is OnboardingLoading ||
        onboardingState is OnboardingPageInitial) {
      return const _LoadingScreen();
    }

    if (onboardingState is OnboardingSeenLoaded) {
      final bool onboardingSeen = onboardingState.seen;
      return onboardingSeen ? const HomeScreen() : const OnboardingPage();
    }

    return Center(child: Text("Error"));
  }
}

class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
