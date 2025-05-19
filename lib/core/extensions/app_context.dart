import 'package:flutter/material.dart';
import 'package:tafaling/core/theme/styles/app_text_style.dart';
import 'package:tafaling/core/theme/styles/large_text_style.dart';
import 'package:tafaling/core/theme/styles/medium_text_style.dart';
import 'package:tafaling/core/theme/styles/small_text_style.dart';
import 'package:tafaling/core/theme/values/dimensions/app_dimensions.dart';
import 'package:tafaling/core/theme/values/dimensions/large_app_dimensions.dart';
import 'package:tafaling/core/theme/values/dimensions/medium_app_dimensions.dart';
import 'package:tafaling/core/theme/values/dimensions/small_app_dimensions.dart';

enum DeviceType { Mobile, Tablet, Desktop }

extension AppContext on BuildContext {
  DeviceType get deviceType {
    final double width = MediaQuery.of(this).size.width;
    if (width < 600) {
      return DeviceType.Mobile;
    } else if (width < 1200) {
      return DeviceType.Tablet;
    } else {
      return DeviceType.Desktop;
    }
  }

  bool get isMobile => deviceType == DeviceType.Mobile;
  bool get isTablet => deviceType == DeviceType.Tablet;
  bool get isDesktop => deviceType == DeviceType.Desktop;

  AppTextStyle get textStyle {
    switch (deviceType) {
      case DeviceType.Mobile:
        return SmallTextStyle();
      case DeviceType.Tablet:
        return MediumTextStyle();
      case DeviceType.Desktop:
        return LargeTextStyle();
    }
  }

  AppDimensions get appDimensions {
    switch (deviceType) {
      case DeviceType.Mobile:
        return SmallAppDimensions();
      case DeviceType.Tablet:
        return MediumAppDimensions();
      case DeviceType.Desktop:
        return LargeAppDimensions();
    }
  }

  ThemeData get theme {
    return Theme.of(this);
  }
}
