import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/constants/constants.dart';
import 'package:tafaling/core/injection.dart';
import 'package:tafaling/core/services/local_storage/local_storage.dart';
import 'package:tafaling/injection.dart';
import 'package:tafaling/my_app.dart';
import 'package:tafaling/shared/widgets/theme_selector/bloc/theme_selector_bloc.dart';

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
          create: (context) => sl<ThemeSelectorBloc>()..add(LoadTheme()),
        ),
      ],
      child: MyApp(onBoarding: onBoarding),
    ),
  );
}
