import 'package:flutter/material.dart';
import 'package:flutter_skeleton/shared/styles/app_text_style.dart';
import 'package:flutter_skeleton/shared/styles/lg_text_style.dart';
import 'package:flutter_skeleton/shared/styles/md_text_style.dart';
import 'package:flutter_skeleton/shared/styles/sm_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        return SmTextStyle();
      case DeviceType.Tablet:
        return MdTextStyle();
      case DeviceType.Desktop:
        return LgTextStyle();
      default:
        return MdTextStyle();
    }
  }

  AppLocalizations get stringResource =>
      AppLocalizations.of(this) ?? lookupAppLocalizations(Locale('en'));
}
