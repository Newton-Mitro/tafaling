import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/constants/constants.dart';
import 'package:tafaling/core/widgets/language_selector/bloc/language_bloc.dart';
import 'package:tafaling/core/widgets/theme_switcher/bloc/theme_bloc.dart';
import 'package:tafaling/features/home/presentation/notifier/notifiers.dart';
import 'package:tafaling/features/user/data/models/user_model.dart';
import 'package:tafaling/injection.dart';
import 'package:tafaling/my_app.dart';

import 'core/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies(); // Register dependencies
  final localStorage = sl<LocalStorage>();

  final bool onBoarding =
      await localStorage.getBool(Constants.onboardingKey) ?? true;

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<LanguageBloc>()..add(LoadLocaleEvent()),
        ),
        BlocProvider(
          create: (context) => sl<ThemeBloc>()..add(LoadThemeEvent()),
        ),
      ],
      child: MyApp(onBoarding: onBoarding),
    ),
  );
}
