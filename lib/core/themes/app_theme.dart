import 'package:flutter/material.dart';

class AppTheme {
  static const primary = Color(0xFF007074);
  static const secondary = Color(0xFF769596);
  static const tertiary = Color(0xFFA8D5BA);

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'JakartaSans',
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      primary: primary,
      secondary: secondary,
      tertiary: tertiary,
      brightness: Brightness.light,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: tertiary,
      selectedItemColor: primary,
      unselectedItemColor: secondary,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'JakartaSans',
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      primary: primary,
      secondary: secondary,
      tertiary: tertiary,
      brightness: Brightness.dark,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: secondary,
      selectedItemColor: tertiary,
      unselectedItemColor: Colors.grey,
    ),
  );
}
