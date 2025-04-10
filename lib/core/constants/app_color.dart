import 'package:flutter/material.dart';

class AppColors {
  // Light Mode
  static var light = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff0E592C), // Warna utama (Hijau)
    secondary: Color(0xffD4EAE1), // Warna sekunder (Soft Green)
    surface: const Color.fromARGB(255, 241, 241, 241), // Background utama
    surfaceContainerHighest: Color(0xFFF5F5F5), // Alternatif background
    onPrimary: Colors.black, // Warna teks pada tombol utama
    onSecondary: Colors.black, // Warna teks pada tombol sekunder
    onSurface: Colors.black, // Warna teks pada elemen utama
    error: Colors.red, // Warna error
    onError: Colors.white, // Warna teks pada error
    outline: Color(0xFFBDBDBD), // Warna outline atau border
  );
      

  // Dark Mode
  static var dark = ColorScheme(
    brightness: Brightness.dark,
    primary: Color.fromARGB(255, 0, 0, 0), // Warna utama (Soft Green)
    secondary: Color(0xffD4EAE1), // Warna sekunder (Hijau Gelap)
    surface: Color(0xFF1E1E1E), // Background utama (gelap)
    surfaceContainerHighest: Color(0xFF2C2C2C), // Alternatif background gelap
    onPrimary: Colors.white, // Warna teks pada tombol utama
    onSecondary: Colors.white, // Warna teks pada tombol sekunder
    onSurface: Colors.white, // Warna teks utama pada background gelap
    error: Colors.redAccent, // Warna error
    onError: Colors.black, // Warna teks pada error
    outline: Color(0xFF757575), // Warna outline atau border
  );

  // Light Mode
  static var lightCostum = (
    onWarning: Color.fromARGB(255, 185, 147, 50), // Warna untuk peringatan
    onSuccess: Color(0xFF0E592C), // Warna untuk sukses
  );

  // Dark Mode
  static var darkCostum = (
    onWarning: Color(0xFFEABB44), // Warna untuk peringatan
    onSuccess: Color(0xFF0E592C), // Warna untuk sukses
  );
}
