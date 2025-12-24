import 'package:flutter/material.dart';
import 'package:alkor_shopin/core/themes/color_scheme.dart';
import 'package:alkor_shopin/core/themes/text_themes.dart';


class AppThemes {
  // Light Theme
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    brightness: Brightness.light,
    textTheme: appTextTheme,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      centerTitle: true,
      titleTextStyle: appTextTheme.titleLarge?.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      ),
    ),

    useMaterial3: true, // Optional: enables Material 3 styling
  );

  // Dark Theme
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blueGrey,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueGrey,
      brightness: Brightness.dark,
    ),
  );
}
