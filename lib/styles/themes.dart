import 'package:flutter/material.dart';

import 'colors.dart';

abstract class Themes {
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    hintColor: AppColorsDark.hintColor,
    scaffoldBackgroundColor: AppColorsDark.backgroundColor,
  );

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      hintColor: AppColorsLight.hintColor,
      scaffoldBackgroundColor: AppColorsLight.backgroundColor,
      textTheme: const TextTheme(
        titleMedium: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w600,
          color: AppColorsLight.primaryTextColor,
        ),
      ));
}
