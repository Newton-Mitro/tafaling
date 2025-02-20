import 'package:flutter/material.dart';

import 'package:flutter_skeleton/shared/styles/app_text_style.dart';

class LgTextStyle extends AppTextStyle {
  @override
  TextStyle get appBarTextStyle => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get titleTextStyle => TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get subTitleTextStyle => TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get bodyTextStyle => TextStyle(
        fontSize: 18,
      );

  @override
  TextStyle get buttonTextStyle => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get captionTextStyle => TextStyle(
        fontSize: 14,
      );

  @override
  TextStyle get overlineTextStyle => TextStyle(
        fontSize: 12,
      );
}
