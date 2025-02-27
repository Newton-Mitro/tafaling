import 'package:flutter/material.dart';
import 'package:tafaling/res/values/colors/dark_colors.dart';
import 'package:tafaling/res/values/colors/light_colors.dart';

class AppTheme {
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColorsDark().background,
        colorScheme: ColorScheme.dark(
          primary: AppColorsDark().primary,
          secondary: AppColorsDark().secondary,
          surface: AppColorsDark().surface,
          error: AppColorsDark().error,
          onPrimary: AppColorsDark().onPrimary,
          onSecondary: AppColorsDark().onSecondary,
          onSurface: AppColorsDark().onSurface,
          onError: AppColorsDark().onError,
        ),
        popupMenuTheme: PopupMenuThemeData(
          color: AppColorsDark().surface,
          textStyle: _textTheme.bodyMedium,
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.all(AppColorsDark().primary),
          trackColor: WidgetStateProperty.all(AppColorsDark().onSurface),
        ),
        textTheme: _textTheme,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColorsDark().primary,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColorsDark().onBackground),
        ),
        // bottomNavigationBarTheme: BottomNavigationBarThemeData(
        //   backgroundColor: AppColorsDark().background,
        //   elevation: 0,
        //   selectedItemColor: AppColorsDark().primary,
        //   unselectedItemColor: AppColorsDark().onBackground,
        // ),
        scrollbarTheme: ScrollbarThemeData(
          thickness: WidgetStateProperty.all(4),
          radius: Radius.circular(2),
          interactive: true,
          trackColor: WidgetStateProperty.all(AppColorsDark().onBackground),
          crossAxisMargin: 4,
          mainAxisMargin: 4,
        ),
        pageTransitionsTheme: _pageTransitionsTheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColorsLight().background,
        colorScheme: ColorScheme.light(
          primary: AppColorsLight().primary,
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
        appBarTheme: AppBarTheme(
          backgroundColor: AppColorsLight().primary,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColorsLight().onBackground),
        ),
        // bottomNavigationBarTheme: BottomNavigationBarThemeData(
        //   backgroundColor: AppColorsLight().background,
        //   elevation: 0,
        //   selectedItemColor: AppColorsLight().primary,
        //   unselectedItemColor: AppColorsLight().onBackground,
        // ),
        scrollbarTheme: ScrollbarThemeData(
          thickness: WidgetStateProperty.all(4),
          radius: Radius.circular(2),
          interactive: true,
          trackColor: WidgetStateProperty.all(AppColorsLight().onBackground),
          crossAxisMargin: 4,
          mainAxisMargin: 4,
        ),
        pageTransitionsTheme: _pageTransitionsTheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  static const TextTheme _textTheme = TextTheme(
    headlineLarge: TextStyle(
        fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
    headlineMedium: TextStyle(fontSize: 48, fontWeight: FontWeight.w400),
    headlineSmall: TextStyle(
        fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
    bodyLarge: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyMedium: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    bodySmall: TextStyle(
        fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  );

  static const PageTransitionsTheme _pageTransitionsTheme =
      PageTransitionsTheme(
    builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  );
}
