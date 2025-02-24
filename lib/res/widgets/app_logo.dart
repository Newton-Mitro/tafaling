import 'package:flutter/material.dart';
import 'package:flutter_skeleton/res/values/constants/app_images.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImages.logo,
    );
  }
}
