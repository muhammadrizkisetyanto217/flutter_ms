import 'package:flutter/material.dart';
import 'package:flutter_ms/core/constants/app_font.dart';
import 'package:flutter_ms/core/constants/app_sizes.dart';

enum ButtonType {
  primary,
  secondary,
  outline,
  error,
  warning,
  success,
  errorSecondary
}

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType type;
  final double? width; // ✅ Tambahkan opsi untuk mengatur width secara opsional

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.width, // ✅ Bisa dikustomisasi, jika null defaultnya akan full width
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity, // ✅ Jika null, gunakan full width
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: _getButtonStyle(),
        child: Text(text),
      ),
    );
  }

  ButtonStyle _getButtonStyle() {
    switch (type) {
      case ButtonType.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff0E592C),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusMedium),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: AppFont.fontFamily,
          ),
        );
      case ButtonType.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffD4EAE1),
          foregroundColor: const Color(0xff0E592C),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusMedium),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: AppFont.fontFamily,
          ),
        );
      case ButtonType.outline:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: const Color(0xff0E592C),
          side: const BorderSide(color: Color(0xff0E592C)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: AppFont.fontFamily,
          ),
        );
      case ButtonType.error:
        return ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffC03000),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: AppFont.fontFamily,
          ),
        );
      case ButtonType.errorSecondary:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xffC03000),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: AppFont.fontFamily,
          ),
        );
      case ButtonType.warning:
        return ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFC107),
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: AppFont.fontFamily,
          ),
        );
      case ButtonType.success:
        return ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF28A745),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: AppFont.fontFamily,
          ),
        );
    }
  }
}
