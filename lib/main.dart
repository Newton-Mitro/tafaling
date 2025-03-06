import 'package:flutter/material.dart';
import 'package:tafaling/core/utils/app_shared_pref.dart';
import 'package:tafaling/injection_container.dart';
import 'package:tafaling/core/widgets/language_selector/bloc/language_bloc.dart';
import 'package:tafaling/core/widgets/theme_switcher/bloc/theme_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/my_app.dart';

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
        child: MyApp(
          onBoarding: onBoarding,
        )),
  );
}
