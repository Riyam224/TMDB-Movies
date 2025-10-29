import 'package:flutter/material.dart';
import 'package:movies_app/core/theme/color_schemes.dart';

class AppTheme {
  /// ☀️ Light Theme
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: AppColors.orange,
      onPrimary: Colors.white,
      secondary: AppColors.navyBlue,
      onSecondary: Colors.white,
      background: AppColors.white,
      onBackground: Colors.black87,
      surface: Color(0xFFF6F6F6),
      onSurface: Colors.black87,
    ),
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.orange,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
    ),
    textTheme: Typography.blackCupertino,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.orange,
      foregroundColor: Colors.white,
    ),
  );

  /// 🌙 Dark Theme
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.navyBlue,
      onPrimary: Colors.white,
      secondary: AppColors.orange,
      onSecondary: Colors.white,
      background: Color(0xFF121212),
      onBackground: Colors.white70,
      surface: Color(0xFF1E1E1E),
      onSurface: Colors.white70,
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.navyBlue,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
    ),
    textTheme: Typography.whiteCupertino,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.orange,
      foregroundColor: Colors.white,
    ),
  );

  /// 🌸 Custom Pastel Theme (your new palette)
  static final ThemeData customTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: AppColors.blush,
      onPrimary: Colors.white,
      secondary: AppColors.mint,
      onSecondary: Colors.white,
      background: AppColors.cream,
      onBackground: Colors.black87,
      surface: AppColors.palePink,
      onSurface: Colors.black87,
    ),
    scaffoldBackgroundColor: AppColors.cream,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.blush,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        color: AppColors.blush,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(color: AppColors.mint),
      bodyMedium: TextStyle(color: Colors.black87),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.mint,
      foregroundColor: Colors.white,
    ),
  );
}
