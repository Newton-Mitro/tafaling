import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/constants/constants.dart';
import 'package:tafaling/core/injection.dart';
import 'package:tafaling/core/utils/local_storage.dart';
import 'package:tafaling/core/widgets/theme_switcher/bloc/theme_bloc.dart';
import 'package:tafaling/injection.dart';
import 'package:tafaling/my_app.dart';

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
          create: (context) => sl<ThemeBloc>()..add(LoadThemeEvent()),
        ),
      ],
      child: MyApp(onBoarding: onBoarding),
    ),
  );
}
