import 'package:flutter/material.dart';
import 'package:flutter_ms/core/constants/app_color.dart';

class AppFont {
  static const String fontFamily = 'JakartaSans';

  static TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.light.primary,
    fontFamily: fontFamily,
  );

  static TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.light.primary,
    fontFamily: fontFamily,
  );

  static TextStyle heading3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.light.errorContainer,
    fontFamily: fontFamily,
  );

  static TextStyle bodyText1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.dark.error,
    fontFamily: fontFamily,
  );

  static TextStyle bodyText2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.dark.error,
    fontFamily: fontFamily,
  );

  static TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white, // Biasanya warna putih untuk tombol utama
    fontFamily: fontFamily,
  );

  static TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.dark.tertiary,
    fontFamily: fontFamily,
  );
}
