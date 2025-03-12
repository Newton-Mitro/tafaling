import 'package:flutter/material.dart';
import 'package:tafaling/configs/values/colors/app_colors.dart';

class AppColorsDark extends AppColors {
  // Primary Colors
  @override
  Color get primary => const Color(0xFF1F292E);
  @override
  Color get primaryVariant => const Color(0xFF0E1214);
  @override
  Color get onPrimary => const Color(0xFF90B7CC);
  @override
  Color get primaryContainer => const Color(0xFF37474F);
  @override
  Color get onPrimaryContainer => const Color(0xFF90CAF9);
  @override
  Color get primaryFixed => const Color(0xFF0E1214);
  @override
  Color get primaryFixedDim => const Color(0xFF1C1F21);
  @override
  Color get onPrimaryFixed => const Color(0xFF90CAF9);
  @override
  Color get onPrimaryFixedVariant => const Color(0xFF64B5F6);

  // Secondary Colors
  @override
  Color get secondary => const Color(0xFF152024);
  @override
  Color get secondaryVariant => Colors.tealAccent;
  @override
  Color get onSecondary => Colors.white;
  @override
  Color get secondaryContainer => const Color(0xFF004D40);
  @override
  Color get onSecondaryContainer => const Color(0xFF80CBC4);
  @override
  Color get secondaryFixed => const Color(0xFF00332E);
  @override
  Color get secondaryFixedDim => const Color(0xFF002B25);
  @override
  Color get onSecondaryFixed => const Color(0xFF80CBC4);
  @override
  Color get onSecondaryFixedVariant => const Color(0xFF4DB6AC);

  // Tertiary Colors
  @override
  Color get tertiary => const Color(0xFF512DA8);
  @override
  Color get onTertiary => Colors.white;
  @override
  Color get tertiaryContainer => const Color(0xFF673AB7);
  @override
  Color get onTertiaryContainer => const Color(0xFFD1C4E9);
  @override
  Color get tertiaryFixed => const Color(0xFF311B92);
  @override
  Color get tertiaryFixedDim => const Color(0xFF1A0F6A);
  @override
  Color get onTertiaryFixed => const Color(0xFFD1C4E9);
  @override
  Color get onTertiaryFixedVariant => const Color(0xFF9575CD);

  // Error Colors
  @override
  Color get error => Colors.redAccent;
  @override
  Color get onError => Colors.black;
  @override
  Color get errorContainer => const Color(0xFFB00020);
  @override
  Color get onErrorContainer => const Color(0xFFFFCDD2);

  // Background & Surface
  @override
  Color get background => const Color(0xFF1D1D1D);
  @override
  Color get onBackground => Colors.white;
  @override
  Color get surface => const Color(0xFF222222);
  @override
  Color get onSurface => Colors.white;
  @override
  Color get surfaceDim => const Color(0xFF121212);
  @override
  Color get surfaceBright => const Color(0xFF292929);
  @override
  Color get surfaceContainerLowest => const Color(0xFF1E1E1E);
  @override
  Color get surfaceContainerLow => const Color(0xFF222222);
  @override
  Color get surfaceContainer => const Color(0xFF252525);
  @override
  Color get surfaceContainerHigh => const Color(0xFF2C2C2C);
  @override
  Color get surfaceContainerHighest => const Color(0xFF333333);
  @override
  Color get surfaceVariant => const Color(0xFF37474F);
  @override
  Color get onSurfaceVariant => const Color(0xFFECEFF1);
  @override
  Color get surfaceTint => primary;

  // Outline & Shadows
  @override
  Color get outline => const Color(0xFFBDBDBD);
  @override
  Color get outlineVariant => const Color(0xFF757575);
  @override
  Color get shadow => Colors.black;
  @override
  Color get scrim => Colors.black.withOpacity(0.5);

  // Inverse Colors
  @override
  Color get inverseSurface => const Color(0xFFE3E3E3);
  @override
  Color get onInverseSurface => const Color(0xFF121212);
  @override
  Color get inversePrimary => const Color(0xFF90CAF9);

  // Additional UI Colors
  @override
  Color get selected => const Color(0xFFA9DFFC);
  @override
  Color get unSelected => const Color(0xFF90B7CC);
  @override
  Color get disabled => const Color(0xFF91999E);

  // Grayscale Material Color
  @override
  MaterialColor get gray => const MaterialColor(50, {
        50: Color(0xFFEDEDED),
        100: Color(0xFFD6D6D6),
        200: Color(0xFFBDBDBD),
        300: Color(0xFF9E9E9E),
        350: Color(0xFF868686),
        400: Color(0xFF757575),
        500: Color(0xFF616161),
        600: Color(0xFF4E4E4E),
        700: Color(0xFF3B3B3B),
        800: Color(0xFF2C2C2C),
        850: Color(0xFF1F1F1F),
        900: Color(0xFF121212),
      });
}
