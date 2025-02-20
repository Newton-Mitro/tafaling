import 'package:flutter/material.dart';
import 'package:flutter_skeleton/shared/colors/app_colors.dart';

class AppColorsDark extends AppColors {
  @override
  Color get primary => Color(0xFFBB86FC); // Softer purple for dark mode

  @override
  Color get primaryVariant => Color(0xFF3700B3); // Deep purple

  @override
  Color get secondary => Color(0xFF03DAC5); // Teal

  @override
  Color get secondaryVariant => Color(0xFF018786); // Darker teal

  @override
  Color get background => Color(
      0xFF1E1E1E); // Slightly lighter than pure black for better readability

  @override
  Color get surface => Color(0xFF2C2C2C); // Dark gray for card backgrounds

  @override
  Color get error => Color(0xFFCF6679); // Red with enough contrast

  @override
  Color get onPrimary =>
      Color(0xFF121212); // Dark background on primary color for better contrast

  @override
  Color get onSecondary => Color(0xFF000000); // Black on secondary color

  @override
  Color get onBackground =>
      Color(0xFFE0E0E0); // Light gray for good readability on dark background

  @override
  Color get onSurface => Color(0xFFFAFAFA); // White on dark surfaces

  @override
  Color get onError => Color(0xFFFFFFFF); // White on error color

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
