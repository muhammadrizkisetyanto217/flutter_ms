import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(),
      body: IntroductionScreen(
        pages: [
          // Halaman 1
          PageViewModel(
            title: "Selamat Datang semua",
            body: "Selamat datang di aplikasi ini",
            image: Center(
              child: Image.asset(
                'assets/images/Before-Login-Register.png',
                height: 175.0,
              ),
            ),
          ),
          // Halaman 2
          PageViewModel(
            title: "Fitur Unggulan",
            body: "Aplikasi ini memiliki fitur unggulan yang bermanfaat",
            image: Center(
              child: Image.asset('assets/images/Image2.png', height: 175.0),
            ),
          ),
          // Halaman 3
          PageViewModel(
            title: "Mulai Sekarang",
            body: "Mari mulai menggunakan aplikasi ini!",
            image: Center(
              child: Image.asset('assets/images/Image3.png', height: 175.0),
            ),
          ),
        ],
        onDone: () {
          // ✅ Navigasi menggunakan GoRouter setelah selesai
          context.go('/login');
        },
        onSkip: () {
          Navigator.pushReplacementNamed(context, '/login');
        },
        showSkipButton: false,
        next: const Text(
          "Lanjut",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        done: const Text(
          "Mulai",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
