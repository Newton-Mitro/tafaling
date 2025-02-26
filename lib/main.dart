import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_skeleton/core/utils/app_shared_pref.dart';
import 'package:flutter_skeleton/features/home/presentation/pages/home_page.dart';
import 'package:flutter_skeleton/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:flutter_skeleton/injection_container.dart';
import 'package:flutter_skeleton/res/themes/app_theme.dart';
import 'package:flutter_skeleton/res/widgets/language_selector/bloc/language_bloc.dart';
import 'package:flutter_skeleton/res/widgets/theme_switcher/bloc/theme_bloc.dart';
import 'package:flutter_skeleton/core/utils/app_context.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_skeleton/routes.dart';

void main() async {
  getInit();

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final bool onBoarding = await AppSharedPref.getOnboardingStatus() ?? true;

  runApp(
    MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LanguageBloc()..add(LoadLocaleEvent()),
          ),
          BlocProvider(
            create: (context) => ThemeBloc()..add(LoadThemeEvent()),
          ),
        ],
        child: MainApp(
          onBoarding: onBoarding,
        )),
  );
}

class MainApp extends StatelessWidget {
  final bool onBoarding;
  const MainApp({super.key, required this.onBoarding});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, languageState) {
        return BlocConsumer<ThemeBloc, ThemeState>(
          listener: (context, state) {},
          builder: (context, themeState) {
            return MaterialApp(
              title: context.appLocalizations.appName,
              debugShowCheckedModeBanner: false,
              darkTheme: AppTheme.dark,
              theme: AppTheme.light,
              themeMode: themeState is LightThemeState
                  ? ThemeMode.light
                  : ThemeMode.dark,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [
                Locale('en'),
                Locale('bn'),
              ],
              locale: Locale(languageState.language),
              home: onBoarding ? OnboardingPage() : HomePage(),
              onGenerateRoute: AppRoutes().onGenerateRoutes,
            );
          },
        );
      },
    );
  }
}
