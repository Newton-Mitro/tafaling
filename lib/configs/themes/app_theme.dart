import 'package:flutter/material.dart';
import 'package:tafaling/configs/values/colors/dark_colors.dart';
import 'package:tafaling/configs/values/colors/light_colors.dart';

class AppTheme {
  ThemeData get dark => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColorsDark().background,
        colorScheme: ColorScheme.dark(
          primary: AppColorsDark().primary,
          onPrimaryFixed: AppColorsDark().onPrimary,
          secondary: AppColorsDark().secondary,
          surface: AppColorsDark().surface,
          error: AppColorsDark().error,
          onPrimary: AppColorsDark().onPrimary,
          onSecondary: AppColorsDark().onSecondary,
          onSurface: AppColorsDark().onSurface,
          onError: AppColorsDark().onError,
        ),
        filledButtonTheme: FilledButtonThemeData(
            style: ButtonStyle(
          backgroundColor:
              WidgetStatePropertyAll<Color?>(AppColorsDark().secondary),
        )),
        popupMenuTheme: PopupMenuThemeData(
          color: AppColorsDark().surface,
          textStyle: _textTheme.bodyMedium,
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.all(AppColorsDark().primary),
          trackColor: WidgetStateProperty.all(AppColorsDark().onSurface),
        ),
        textTheme: _textTheme,
        fontFamily: 'Roboto',
        appBarTheme: AppBarTheme(
          backgroundColor: AppColorsDark().primary,
          titleTextStyle: TextStyle(
            fontSize: 18,
            color: AppColorsDark().onPrimary,
          ),
          elevation: 0,
          iconTheme: IconThemeData(
            color: AppColorsDark().onPrimary,
          ),
        ),
        tabBarTheme: TabBarThemeData(
          indicatorColor: AppColorsDark().error,
          dividerColor: AppColorsDark().primaryVariant,
          labelColor: AppColorsDark().selected,
          unselectedLabelColor: AppColorsDark().unSelected,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColorsDark().primary,
          unselectedItemColor: AppColorsDark().unSelected,
          selectedItemColor: AppColorsDark().selected,
        ),
        pageTransitionsTheme: _pageTransitionsTheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  ThemeData get light => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColorsLight().background,
        colorScheme: ColorScheme.light(
          primary: AppColorsLight().primary,
          onPrimaryFixed: AppColorsLight().onPrimary,
          secondary: AppColorsLight().secondary,
          surface: AppColorsLight().surface,
          error: AppColorsLight().error,
          onPrimary: AppColorsLight().onPrimary,
          onSecondary: AppColorsLight().onSecondary,
          onSurface: AppColorsLight().onSurface,
          onError: AppColorsLight().onError,
        ),
        popupMenuTheme: PopupMenuThemeData(
          color: AppColorsLight().surface,
          textStyle: _textTheme.bodyMedium,
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.all(AppColorsLight().primary),
          trackColor: WidgetStateProperty.all(AppColorsLight().onSurface),
        ),
        textTheme: _textTheme,
        fontFamily: 'Roboto',
        appBarTheme: AppBarTheme(
          backgroundColor: AppColorsLight().primary,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColorsLight().onBackground),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColorsLight().primary,
          unselectedItemColor: AppColorsLight().onPrimary,
          selectedItemColor: AppColorsLight().secondary,
        ),
        pageTransitionsTheme: _pageTransitionsTheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  final TextTheme _textTheme = TextTheme(
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.6,
      height: 1.5,
      color: AppColorsDark().onPrimary,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.4,
      height: 1.4,
      color: AppColorsDark().onPrimary,
    ),
    bodySmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.3,
      height: 1.3,
      color: AppColorsDark().onPrimary,
    ),
    labelLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
      height: 1.4,
      color: AppColorsDark().onPrimary,
    ),
    labelMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.4,
      height: 1.3,
      color: AppColorsDark().onPrimary,
    ),
    labelSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.3,
      height: 1.2,
      color: AppColorsDark().onPrimary,
    ),
    headlineLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.8,
      height: 1.6,
      color: AppColorsDark().onPrimary,
    ),
    headlineMedium: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.7,
      height: 1.5,
      color: AppColorsDark().onPrimary,
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.6,
      height: 1.4,
      color: AppColorsDark().onPrimary,
    ),
  );

  final PageTransitionsTheme _pageTransitionsTheme = PageTransitionsTheme(
    builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  );
}
