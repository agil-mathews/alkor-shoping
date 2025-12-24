import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

Orientation  getScreenOrientation(BuildContext context) {
  return MediaQuery.of(context).orientation;
}

  double getResponsiveFontSize(
    BuildContext context, {
    required double defaultFontSize,
    double? widePortraitFontSize,
    double? landscapeNarrowFontSize,
    double? landscapeWideFontSize,
    double? smallScreenFontSize, // New optional param
  }) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final screenWidth = getScreenWidth(context);

      if (screenWidth <= 380) {
    return (smallScreenFontSize ?? defaultFontSize - 2).sp; // scale down by 2 or use provided size
  }

        if (screenWidth <= 350) {
    return (smallScreenFontSize ?? defaultFontSize - 4).sp; // scale down by 2 or use provided size
  }

    if (isLandscape) {
      if (screenWidth > 800) {
        return (landscapeWideFontSize ?? defaultFontSize).sp;
      } else {
        return (landscapeNarrowFontSize ?? defaultFontSize).sp;
      }
    } else {
      if (screenWidth > 500) {
        return (widePortraitFontSize ?? defaultFontSize).sp;
      } else {
        return defaultFontSize.sp;
      }
    }
  }

extension ResponsiveContext on BuildContext {
  bool get isTablet => MediaQuery.of(this).size.width >= 600;
  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;
  bool get isTabLetPortrait => isTablet && isPortrait;
  bool get isLandscape => !isPortrait;
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get pixelratio => MediaQuery.of(this).devicePixelRatio;
}
