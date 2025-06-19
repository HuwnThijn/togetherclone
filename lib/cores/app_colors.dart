import 'package:flutter/material.dart';

class AppColors {
  static const primaryDark = Color(0xff2E2E2C);
  static const primaryLight = Color(0xffE7E6DC);
  static Color accentDark = Color(0xffED334A);
  static Color accentLight = Color(0xffED334A);
  static const backgroundLight = Color(0xffF6F6F6);
  static const backgroundDark = Color(0xff2E2E2C);
  static const surfaceLight = Colors.white;
  static const surfaceDark = Color(0xFF121212);
  static const errorLight = Color(0xFFE8505B);
  static const errorDark = Color(0xFFE8505B);
  static Color lineLight = Colors.black.withValues(alpha: .05);
  static Color lineDark = Colors.white.withValues(alpha: .05);
  static const icon = Color(0xff6363FC);
  static const textDark = Colors.black;
  static const textLight = Colors.white;
  static const border = Color(0xffEDEDED);
  static const indicator = Color(0xffFFCD29);
  static const unSelectedColorLight = Color(0xffCDCDCD);
  static const unSelectedColorDark = Color(0xff303030);
  static const iconLight = Color(0xffCDCDCD);
  static const iconDark = Color(0xff303030);
  static const buttonGrayLight = Color(0xffF4F4F4);
  static const buttonGrayDark = Color(0xff222222);
  static const buttonGreen = Color(0xff00C31D);
  static const ogrange = Color(0xffFF8965);
  static const ograngePremium = Color(0xffFFB532);
  static const contentColorDark = Color(0xff232323);
  static const contentColorLight = Color(0xffF6F6F6);

  static final List<Color> gradient = [Color(0xff00C6FF), Color(0xff6363FC)];

  static Color unIndicatorColor(bool isDark) {
    return isDark ? Colors.black : Colors.white;
  }

  static void setMainColor(Color color) {
    accentDark = color;
    accentLight = color;
  }
}
