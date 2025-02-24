import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_skeleton/pages/home_page/home_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_skeleton/shared/themes/app_theme.dart';
import 'package:flutter_skeleton/shared/widgets/language_selector/bloc/language_bloc.dart';
import 'package:flutter_skeleton/shared/widgets/theme_switcher/bloc/theme_bloc.dart';
import 'package:flutter_skeleton/utils/app_context.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => LanguageBloc(),
      ),
      BlocProvider(
        create: (context) => ThemeBloc(),
      ),
    ], child: const MainApp()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LanguageBloc, LanguageState>(
      listener: (context, state) {},
      builder: (context, state) {
        return MaterialApp(
          title: context.appLocalizations.appName,
          debugShowCheckedModeBanner: false,
          darkTheme: AppTheme.dark,
          theme: AppTheme.light,
          themeMode: ThemeMode.light,
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
          locale: Locale(state.language),
          home: HomePage(),
        );
      },
    );
  }
}
