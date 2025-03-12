import 'package:flutter/material.dart';
import 'package:tafaling/core/constants/app_images.dart';

class AppLogo extends StatelessWidget {
  final double width;

  const AppLogo({super.key, this.width = 32});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImages.logo,
      width: width,
    );
  }
}
