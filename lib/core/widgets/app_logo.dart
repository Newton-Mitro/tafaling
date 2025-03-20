import 'package:flutter/material.dart';
import 'package:tafaling/core/constants/app_images.dart';

class AppLogo extends StatelessWidget {
  final double width;
  final double height;

  const AppLogo({super.key, this.width = 30, this.height = 30});

  @override
  Widget build(BuildContext context) {
    return Image.asset(AppImages.splash, width: width, height: height);
  }
}
