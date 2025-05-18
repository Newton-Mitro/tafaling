import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:tafaling/core/injection.dart';
import 'package:tafaling/features/onboarding/presentation/bloc/onboarding_page_bloc.dart';
import 'package:tafaling/injection.dart';
import 'package:tafaling/my_app.dart';
import 'package:tafaling/shared/widgets/language_switch/bloc/language_switch_bloc.dart';
import 'package:tafaling/shared/widgets/theme_selector/bloc/theme_selector_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Locales.init(['en', 'bn']);
  await setupDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<LanguageSwitchBloc>()..add(LoadLocaleEvent()),
        ),
        BlocProvider(create: (_) => sl<ThemeSelectorBloc>()..add(LoadTheme())),
        BlocProvider(create: (_) => sl<OnboardingPageBloc>()),
      ],
      child: MyApp(),
    ),
  );
}
