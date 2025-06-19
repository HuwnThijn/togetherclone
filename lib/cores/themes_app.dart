// ignore_for_file: avoid_init_to_null

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/config.dart';
import 'package:lovejourney/cores/shared.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primaryLight,
  scaffoldBackgroundColor: AppColors.backgroundLight,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.backgroundLight,
    centerTitle: true,
    iconTheme: IconThemeData(color: AppColors.primaryDark),
    shadowColor: AppColors.backgroundLight,
    foregroundColor: AppColors.backgroundLight,
    surfaceTintColor: AppColors.backgroundLight,
  ),
  dialogTheme: const DialogThemeData(backgroundColor: AppColors.surfaceLight),
  disabledColor: AppColors.unSelectedColorLight,
  splashColor: AppColors.primaryDark.withValues(alpha: .1),
  highlightColor: Colors.transparent,
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColors.primaryLight,
    selectionColor: AppColors.primaryLight,
    selectionHandleColor: AppColors.primaryLight,
  ),
  focusColor: AppColors.primaryLight,
  primaryColorDark: AppColors.primaryLight,
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: AppColors.backgroundLight,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(Configs.commonRadius),
        topRight: Radius.circular(Configs.commonRadius),
      ),
    ),
  ),
  cardColor: AppColors.surfaceLight,
  iconTheme: const IconThemeData(color: AppColors.iconLight),
  cardTheme: const CardThemeData(
    color: AppColors.surfaceLight,
    surfaceTintColor: AppColors.surfaceLight,
  ),
  dividerTheme: DividerThemeData(color: AppColors.lineLight),
  unselectedWidgetColor: AppColors.unSelectedColorLight,
  dividerColor: AppColors.lineLight,
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      side: WidgetStateProperty.all(BorderSide(color: AppColors.border)),
      shape: WidgetStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Configs.commonRadius),
      )),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(AppColors.primaryLight),
      shadowColor: WidgetStatePropertyAll(AppColors.primaryLight),
      shape: WidgetStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Configs.commonRadius),
      )),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStateProperty.all(EdgeInsets.zero),
      // shape: WidgetStateProperty.all(
      //   RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(Configs.commonRadius),
      //   ),
      // ),
      minimumSize: WidgetStateProperty.all(
        Size(70, Configs.commonHeightButton),
      ),
      backgroundColor: WidgetStateProperty.all(AppColors.primaryLight),
      overlayColor: WidgetStateProperty.all(
        AppColors.primaryLight.withValues(alpha: .1),
      ),
      shape: WidgetStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Configs.commonRadius),
      )),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.surfaceLight,
  ),
  tabBarTheme: TabBarThemeData(
    labelColor: AppColors.textLight,
    unselectedLabelColor: AppColors.textDark,
    dividerHeight: 0,
    labelStyle: ThemeData.light().textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w400,
        ),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontFamily: Shared.instance.fontFamily,
      color: AppColors.textDark,
    ),
    displayMedium: TextStyle(
      fontFamily: Shared.instance.fontFamily,
      color: AppColors.textDark,
    ),
    displaySmall: TextStyle(
      fontFamily: Shared.instance.fontFamily,
      color: AppColors.textDark,
    ),
    headlineLarge: TextStyle(
      fontFamily: Shared.instance.fontFamily,
      color: AppColors.textDark,
    ),
    headlineMedium: TextStyle(
      fontFamily: Shared.instance.fontFamily,
      color: AppColors.textDark,
    ),
    headlineSmall: TextStyle(
      fontFamily: Shared.instance.fontFamily,
      color: AppColors.textDark,
    ),
    titleLarge: TextStyle(
      fontFamily: Shared.instance.fontFamily,
      color: AppColors.textDark,
    ),
    titleMedium: TextStyle(
      fontFamily: Shared.instance.fontFamily,
      color: AppColors.textDark,
    ),
    titleSmall: TextStyle(
      fontFamily: Shared.instance.fontFamily,
      color: AppColors.textDark,
    ),
    bodyLarge: TextStyle(
      fontFamily: Shared.instance.fontFamily,
      color: AppColors.textDark,
    ),
    bodyMedium: TextStyle(
      fontFamily: Shared.instance.fontFamily,
      color: AppColors.textDark,
    ),
    bodySmall: TextStyle(
      fontFamily: Shared.instance.fontFamily,
      color: AppColors.textDark,
    ),
    labelLarge: TextStyle(
      fontFamily: Shared.instance.fontFamily,
      color: AppColors.textDark,
    ),
    labelMedium: TextStyle(
      fontFamily: Shared.instance.fontFamily,
      color: AppColors.textDark,
    ),
    labelSmall: TextStyle(
      fontFamily: Shared.instance.fontFamily,
      color: AppColors.textDark,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primaryDark,
  scaffoldBackgroundColor: AppColors.backgroundDark,
  dialogTheme: const DialogThemeData(backgroundColor: AppColors.contentColorDark),
  primaryColorDark: AppColors.primaryDark,
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColors.primaryLight,
    selectionColor: AppColors.primaryLight,
    selectionHandleColor: AppColors.primaryLight,
  ),
  cardColor: AppColors.contentColorDark,
  iconTheme: IconThemeData(color: AppColors.iconDark),
  dividerTheme: DividerThemeData(color: AppColors.lineDark),
  cardTheme: const CardThemeData(
    color: AppColors.contentColorDark,
    surfaceTintColor: AppColors.contentColorDark,
  ),
  unselectedWidgetColor: AppColors.unSelectedColorDark,
  dividerColor: AppColors.lineDark,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.backgroundDark,
    centerTitle: true,
    iconTheme: IconThemeData(color: AppColors.primaryDark),
    shadowColor: AppColors.backgroundDark,
    foregroundColor: AppColors.backgroundDark,
    surfaceTintColor: AppColors.backgroundDark,
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      side: WidgetStateProperty.all(BorderSide(color: AppColors.border)),
      shape: WidgetStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Configs.commonRadius),
      )),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.surfaceDark,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(AppColors.primaryLight),
      shadowColor: WidgetStatePropertyAll(AppColors.primaryLight),
      shape: WidgetStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Configs.commonRadius),
      )),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      // shape: WidgetStateProperty.all(
      //   RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(Configs.commonRadius),
      //   ),
      // ),
      padding: WidgetStateProperty.all(EdgeInsets.zero),
      backgroundColor: WidgetStateProperty.all(AppColors.primaryLight),
      minimumSize: WidgetStateProperty.all(
        Size(70, Configs.commonHeightButton),
      ),
      overlayColor: WidgetStateProperty.all(
        AppColors.primaryLight.withValues(alpha: .1),
      ),
      shape: WidgetStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Configs.commonRadius),
      )),
    ),
  ),
  tabBarTheme: TabBarThemeData(
    labelColor: AppColors.textLight,
    unselectedLabelColor: AppColors.textDark,
    dividerHeight: 0,
    labelStyle: ThemeData.dark().textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w400,
        ),
  ),
  splashColor: AppColors.primaryDark.withValues(alpha: .2),
  highlightColor: Colors.transparent,
  disabledColor: AppColors.unSelectedColorDark,
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: AppColors.backgroundDark,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(Configs.commonRadius),
        topRight: Radius.circular(Configs.commonRadius),
      ),
    ),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontFamily: Shared.instance.fontFamily,
      color: AppColors.textLight,
    ),
    displayMedium: TextStyle(
      fontFamily: Shared.instance.fontFamily,
      color: AppColors.textLight,
    ),
    displaySmall: TextStyle(
      fontFamily: Shared.instance.fontFamily,
      color: AppColors.textLight,
    ),
    headlineLarge: TextStyle(
      fontFamily: Shared.instance.fontFamily,
      color: AppColors.textLight,
    ),
    headlineMedium: TextStyle(
      fontFamily: Shared.instance.fontFamily,
      color: AppColors.textLight,
    ),
    headlineSmall: TextStyle(
      fontFamily: Shared.instance.fontFamily,
      color: AppColors.textLight,
    ),
    titleLarge: TextStyle(
      fontFamily: Shared.instance.fontFamily,
      color: AppColors.textLight,
    ),
    titleMedium: TextStyle(
      fontFamily: Shared.instance.fontFamily,
      color: AppColors.textLight,
    ),
    titleSmall: TextStyle(
      fontFamily: Shared.instance.fontFamily,
      color: AppColors.textLight,
    ),
    bodyLarge: TextStyle(
      fontFamily: Shared.instance.fontFamily,
      color: AppColors.textLight,
    ),
    bodyMedium: TextStyle(
      fontFamily: Shared.instance.fontFamily,
      color: AppColors.textLight,
    ),
    bodySmall: TextStyle(
      fontFamily: Shared.instance.fontFamily,
      color: AppColors.textLight,
    ),
    labelLarge: TextStyle(
      fontFamily: Shared.instance.fontFamily,
      color: AppColors.textLight,
    ),
    labelMedium: TextStyle(
      fontFamily: Shared.instance.fontFamily,
      color: AppColors.textLight,
    ),
    labelSmall: TextStyle(
      fontFamily: Shared.instance.fontFamily,
      color: AppColors.textLight,
    ),
  ),
);
