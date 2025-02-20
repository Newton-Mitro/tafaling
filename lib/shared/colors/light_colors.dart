import 'package:flutter/material.dart';
import 'package:flutter_skeleton/shared/colors/app_colors.dart';

class AppColorsLight extends AppColors {
  @override
  Color get primary => Color(0xFF6200EE); // Rich purple

  @override
  Color get primaryVariant => Color(0xFF3700B3); // Deep purple

  @override
  Color get secondary => Color(0xFF03DAC6); // Vibrant teal

  @override
  Color get secondaryVariant => Color(0xFF018786); // Darker teal

  @override
  Color get background => Color(0xFFFFFFFF); // White for a clean, bright look

  @override
  Color get surface => Color(0xFFF5F5F5); // Light gray for a subtle contrast

  @override
  Color get error => Color(0xFFB00020); // Darker red for better readability

  @override
  Color get onPrimary => Color(0xFFFFFFFF); // White text on primary color

  @override
  Color get onSecondary => Color(0xFF000000); // Black text on secondary color

  @override
  Color get onBackground => Color(0xFF000000); // Black text on light background

  @override
  Color get onSurface => Color(0xFF121212); // Dark text for better readability

  @override
  Color get onError => Color(0xFFFFFFFF); // White text on error color

  @override
  MaterialColor get gray => MaterialColor(50, {
        50: Color(0xFFFAFAFA),
        100: Color(0xFFF5F5F5),
        200: Color(0xFFEEEEEE),
        300: Color(0xFFE0E0E0),
        350: Color(0xFFD6D6D6),
        400: Color(0xFFBDBDBD),
        500: Color(0xFF9E9E9E),
        600: Color(0xFF757575),
        700: Color(0xFF616161),
        800: Color(0xFF424242),
        850: Color(0xFF303030),
        900: Color(0xFF212121),
      });
  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);
  static const transparent = Color(0x00FFFFFF);
  static const shadow = Color(0x44000000);
  static const shadowDark = Color(0x1E000000);
  static const shadowLight = Color(0x33000000);
  static const shadowWhite = Color(0x1AFFFFFF);
  static const shadowWhiteDark = Color(0x0DFFFFFF);
  static const shadowWhiteLight = Color(0x26FFFFFF);
  static const shadowBlack = Color(0x1A000000);
  static const shadowBlackDark = Color(0x0D000000);
  static const shadowBlackLight = Color(0x26FFFFFF);
  static const shadowGrey = Color(0x1A9E9E9E);
  static const shadowGreyDark = Color(0x0D9E9E9E);
  static const shadowGreyLight = Color(0x269E9E9E);
  static const shadowRed = Color(0x1ACF6679);
  static const shadowRedDark = Color(0x0DCF6679);
  static const shadowRedLight = Color(0x26CF6679);
  static const shadowGreen = Color(0x1A4CAF50);
  static const shadowGreenDark = Color(0x0D4CAF50);
  static const shadowGreenLight = Color(0x264CAF50);
  static const shadowBlue = Color(0x1A2196F3);
  static const shadowBlueDark = Color(0x0D2196F3);
  static const shadowBlueLight = Color(0x262196F3);
  static const shadowYellow = Color(0x1AFFC107);
  static const shadowYellowDark = Color(0x0DFFC107);
  static const shadowYellowLight = Color(0x26FFC107);
  static const shadowPurple = Color(0x1A9C27B0);
  static const shadowPurpleDark = Color(0x0D9C27B0);
  static const shadowPurpleLight = Color(0x269C27B0);
  static const shadowOrange = Color(0x1AFF9800);
  static const shadowOrangeDark = Color(0x0DFF9800);
  static const shadowOrangeLight = Color(0x26FF9800);
  static const shadowBrown = Color(0x1A795548);
  static const shadowBrownDark = Color(0x0D795548);
  static const shadowBrownLight = Color(0x26795548);
  static const shadowPink = Color(0x1AE91E63);
  static const shadowPinkDark = Color(0x0DE91E63);
  static const shadowPinkLight = Color(0x26E91E63);
  static const shadowTeal = Color(0x1A009688);
  static const shadowTealDark = Color(0x00009688);
  static const shadowTealLight = Color(0x26009688);
  static const shadowIndigo = Color(0x1A3F51B5);
  static const shadowIndigoDark = Color(0x0D3F51B5);
  static const shadowIndigoLight = Color(0x263F51B5);
  static const shadowCyan = Color(0x1A00BCD4);
  static const shadowCyanDark = Color(0x0000BCD4);
  static const shadowCyanLight = Color(0x2600BCD4);
  static const shadowLime = Color(0x1ACDDC39);
  static const shadowLimeDark = Color(0x0DCDDC39);
  static const shadowLimeLight = Color(0x26CDDC39);
  static const shadowAmber = Color(0x1AFFC107);
  static const shadowAmberDark = Color(0x0DFFC107);
  static const shadowAmberLight = Color(0x26FFC107);
  static const shadowDeepOrange = Color(0x1AFF5722);
  static const shadowDeepOrangeDark = Color(0x0DFF5722);
  static const shadowDeepOrangeLight = Color(0x26FF5722);
  static const shadowDeepPurple = Color(0x1A673AB7);
  static const shadowDeepPurpleDark = Color(0x0D673AB7);
  static const shadowDeepPurpleLight = Color(0x26673AB7);
  static const shadowLightGreen = Color(0x1ACDDC39);
  static const shadowLightGreenDark = Color(0x0DCDDC39);
  static const shadowLightGreenLight = Color(0x26CDDC39);
  static const shadowBlueGrey = Color(0x1A607D8B);
  static const shadowBlueGreyDark = Color(0x0D607D8B);
  static const shadowBlueGreyLight = Color(0x26607D8B);
  static const shadowGreyBlack = Color(0x1A000000);
  static const shadowGreyBlackDark = Color(0x0D000000);
  static const shadowGreyBlackLight = Color(0x26000000);
  static const shadowGreyWhite = Color(0x1AFFFFFF);
  static const shadowGreyWhiteDark = Color(0x0DFFFFFF);
  static const shadowGreyWhiteLight = Color(0x26FFFFFF);
  static const shadowGreyGrey = Color(0x1A9E9E9E);
  static const shadowGreyGreyDark = Color(0x0D9E9E9E);
  static const shadowGreyGreyLight = Color(0x269E9E9E);
  static const shadowGreyRed = Color(0x1ACF6679);
  static const shadowGreyRedDark = Color(0x0DCF6679);
  static const shadowGreyRedLight = Color(0x26CF6679);
  static const shadowGreyGreen = Color(0x1A4CAF50);
  static const shadowGreyGreenDark = Color(0x0D4CAF50);
  static const shadowGreyGreenLight = Color(0x264CAF50);
  static const shadowGreyBlue = Color(0x1A2196F3);
  static const shadowGreyBlueDark = Color(0x0D2196F3);
  static const shadowGreyBlueLight = Color(0x262196F3);
  static const shadowGreyYellow = Color(0x1AFFC107);
  static const shadowGreyYellowDark = Color(0x0DFFC107);
  static const shadowGreyYellowLight = Color(0x26FFC107);
  static const shadowGreyPurple = Color(0x1A9C27B0);
  static const shadowGreyPurpleDark = Color(0x0D9C27B0);
  static const shadowGreyPurpleLight = Color(0x269C27B0);
  static const shadowGreyOrange = Color(0x1AFF9800);
  static const shadowGreyOrangeDark = Color(0x0DFF9800);
  static const shadowGreyOrangeLight = Color(0x26FF9800);
  static const shadowGreyBrown = Color(0x1A795548);
  static const shadowGreyBrownDark = Color(0x0D795548);
  static const shadowGreyBrownLight = Color(0x26795548);
  static const shadowGreyPink = Color(0x1AE91E63);
  static const shadowGreyPinkDark = Color(0x0DE91E63);
  static const shadowGreyPinkLight = Color(0x26E91E63);
  static const shadowGreyTeal = Color(0x1A009688);
  static const shadowGreyTealDark = Color(0x00009688);
  static const shadowGreyTealLight = Color(0x26009688);
  static const shadowGreyIndigo = Color(0x1A3F51B5);
  static const shadowGreyIndigoDark = Color(0x0D3F51B5);
  static const shadowGreyIndigoLight = Color(0x263F51B5);
  static const shadowGreyCyan = Color(0x1A00BCD4);
  static const shadowGreyCyanDark = Color(0x0000BCD4);
  static const shadowGreyCyanLight = Color(0x2600BCD4);
  static const shadowGreyLime = Color(0x1ACDDC39);
  static const shadowGreyLimeDark = Color(0x0DCDDC39);
  static const shadowGreyLimeLight = Color(0x26CDDC39);
  static const shadowGreyAmber = Color(0x1AFFC107);
  static const shadowGreyAmberDark = Color(0x0DFFC107);
  static const shadowGreyAmberLight = Color(0x26FFC107);
  static const shadowGreyDeepOrange = Color(0x1AFF5722);
  static const shadowGreyDeepOrangeDark = Color(0x0DFF5722);
  static const shadowGreyDeepOrangeLight = Color(0x26FF5722);
  static const shadowGreyDeepPurple = Color(0x1A673AB7);
  static const shadowGreyDeepPurpleDark = Color(0x0D673AB7);
  static const shadowGreyDeepPurpleLight = Color(0x26673AB7);
  static const shadowGreyLightGreen = Color(0x1ACDDC39);
  static const shadowGreyLightGreenDark = Color(0x0DCDDC39);
  static const shadowGreyLightGreenLight = Color(0x26CDDC39);
  static const shadowGreyBlueGrey = Color(0x1A607D8B);
  static const shadowGreyBlueGreyDark = Color(0x0D607D8B);
  static const shadowGreyBlueGreyLight = Color(0x26607D8B);
  static const shadowGreyGreyBlack = Color(0x1A000000);
  static const shadowGreyGreyBlackDark = Color(0x0D000000);
  static const shadowGreyGreyBlackLight = Color(0x26000000);
  static const shadowGreyGreyWhite = Color(0x1AFFFFFF);
  static const shadowGreyGreyWhiteDark = Color(0x0DFFFFFF);
  static const shadowGreyGreyWhiteLight = Color(0x26FFFFFF);
  static const shadowGreyGreyGrey = Color(0x1A9E9E9E);
  static const shadowGreyGreyGreyDark = Color(0x0D9E9E9E);
  static const shadowGreyGreyGreyLight = Color(0x269E9E9E);
  static const shadowGreyGreyRed = Color(0x1ACF6679);
  static const shadowGreyGreyRedDark = Color(0x0DCF6679);
  static const shadowGreyGreyRedLight = Color(0x26CF6679);
  static const shadowGreyGreyGreen = Color(0x1A4CAF50);
  static const shadowGreyGreyGreenDark = Color(0x0D4CAF50);
  static const shadowGreyGreyGreenLight = Color(0x264CAF50);
  static const shadowGreyGreyBlue = Color(0x1A2196F3);
  static const shadowGreyGreyBlueDark = Color(0x0D2196F3);
  static const shadowGreyGreyBlueLight = Color(0x262196F3);
  static const shadowGreyGreyYellow = Color(0x1AFFC107);
  static const shadowGreyGreyYellowDark = Color(0x0DFFC107);
  static const shadowGreyGreyYellowLight = Color(0x26FFC107);
}
