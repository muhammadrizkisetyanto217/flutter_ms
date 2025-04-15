import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    required this.size,
    required this.fontWeight,
    required this.color,
  });

  final String text;
  final double size;
  final FontWeight fontWeight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}

// Class Turunan untuk Kemudahan
class CustomText22 extends StatelessWidget {
  const CustomText22({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: text,
      size: TextSize.large,
      fontWeight: FontWeight.w600,
      color: const Color(0xff0E592C),
    );
  }
}

class CustomText20 extends StatelessWidget {
  const CustomText20({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: text,
      size: TextSize.semiLarge,
      fontWeight: FontWeight.w600,
      color: const Color(0xff0E592C),
    );
  }
}

class CustomText18 extends StatelessWidget {
  const CustomText18({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: text,
      size: TextSize.medium,
      fontWeight: FontWeight.w500,
      color: const Color(0xff0E592C),
    );
  }
}

class CustomText16 extends StatelessWidget {
  const CustomText16({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: text,
      size: TextSize.small,
      fontWeight: FontWeight.normal,
      color: const Color(0xff333333), // Default abu-abu gelap
    );
  }
}

// Helper Class untuk Ukuran Font
class TextSize {
  static const double large = 22;
  static const double semiLarge = 20;
  static const double medium = 18;
  static const double small = 16;
}
