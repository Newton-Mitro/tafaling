import 'package:flutter/material.dart';
import 'package:tafaling/configs/values/colors/app_colors.dart';

class AppColorsDark extends AppColors {
  @override
  Color get primary => Colors.blueGrey;

  @override
  Color get primaryVariant => Colors.blueGrey[700]!;

  @override
  Color get secondary => Colors.teal;

  @override
  Color get secondaryVariant => Colors.tealAccent;

  @override
  Color get background => Colors.black;

  @override
  Color get surface => Colors.grey[900]!;

  @override
  Color get error => Colors.redAccent;

  @override
  Color get onPrimary => Colors.white;

  @override
  Color get onSecondary => Colors.white;

  @override
  Color get onBackground => Colors.white;

  @override
  Color get onSurface => Colors.white;

  @override
  Color get onError => Colors.black;

  @override
  MaterialColor get gray => MaterialColor(50, {
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
