import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tafaling/core/utils/app_shared_pref.dart';
import 'package:tafaling/features/home/presentation/pages/home_page.dart';
import 'package:tafaling/features/home/presentation/pages/onboarding_page.dart';
import 'package:tafaling/injection_container.dart';
import 'package:tafaling/configs/themes/app_theme.dart';
import 'package:tafaling/core/widgets/language_selector/bloc/language_bloc.dart';
import 'package:tafaling/core/widgets/theme_switcher/bloc/theme_bloc.dart';
import 'package:tafaling/core/utils/app_context.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getInit();
  final bool onBoarding = await AppSharedPref.getOnboardingStatus();
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
              darkTheme: AppTheme().dark,
              theme: AppTheme().light,
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
