import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ms/core/constants/app_font.dart';
import 'package:flutter_ms/presentation/component/main/fontsize.dart';
import 'package:flutter_ms/presentation/component/user/input_user_component.dart';
import 'package:flutter_ms/presentation/teacher-staff/login-register/login/cubit/login_cubit.dart';
import 'package:flutter_ms/presentation/teacher-staff/login-register/login/cubit/login_state.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controller untuk menangani input email dan password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Fungsi validasi email dengan regex
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // Fungsi validasi password (minimal 6 karakter)
  bool isValidPassword(String password) {
    return password.length >= 6;
  }

  // Fungsi untuk cek apakah form sudah valid
  bool isFormValid() {
    final email = emailController.text.trim();
    final password = passwordController.text;
    return isValidEmail(email) && isValidPassword(password);
  }

  @override
  void initState() {
    super.initState();
    // Tambahkan listener pada controller agar setiap perubahan mengupdate UI
    emailController.addListener(() => setState(() {}));
    passwordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    // Pastikan controller di dispose untuk menghindari memory leak
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Hindari terpotong notch / status bar
      body: SafeArea(
        // Supaya konten bisa digeser saat keyboard muncul
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              // Biar tetap full tinggi meskipun kontennya sedikit
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              // Biar Column mengukur dirinya berdasarkan konten
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    CustomText22(text: "Ahlan wa sahlan"),
                    const SizedBox(height: 16),
                    Text(
                      "Alhamdulillah bisa bertemu kembali, Login untuk melanjutkan pembelajaran",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    InputUser(
                      controller: emailController,
                      hintText: 'Email',
                      icon: Icons.email,
                    ),
                    const SizedBox(height: 20),
                    InputUser(
                      controller: passwordController,
                      hintText: 'Password',
                      icon: Icons.lock,
                      obscureText: true,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          context.go('/forget-password-email');
                        },
                        child: Text(
                          'Lupa Password?',
                          style: TextStyle(
                            color: Color(0xff0E592C),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Gunakan SizedBox sebagai spacer (Expanded tidak cocok di IntrinsicHeight)
                    Expanded(child: Container()),
                    BlocConsumer<LoginCubit, LoginState>(
                      // Dengarkan dan bangun UI berdasarkan state LoginCubit
                      listener: (context, state) {
                        if (state is LoginFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        } else if (state is LoginSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Login berhasil")),
                          );
                          if (state.role == 'admin') {
                            context.go('/data-diri');
                          } else if (state.role == 'user') {
                            context.go('/home');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Role tidak dikenal")),
                            );
                          }
                        }
                      },
                      builder: (context, state) {
                        return SizedBox(
                          width: double.infinity,
                          height: 50, // Atur tinggi tombol
                          child: ElevatedButton(
                            // Atur style tombol berdasarkan validasi form
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  isFormValid()
                                      ? const Color(0xff0E592C) // Warna aktif
                                      : Colors.grey.shade400, // Warna disable
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            // Jika sedang loading atau form tidak valid, tombol dinonaktifkan (null)
                            onPressed:
                                (state is LoginLoading || !isFormValid())
                                    ? null
                                    : () {
                                      final email = emailController.text.trim();
                                      final password = passwordController.text;
                                      // Validasi tambahan untuk memunculkan pesan (meski sebenarnya tombol sudah disable)
                                      if (!isValidEmail(email)) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Format email tidak valid",
                                            ),
                                          ),
                                        );
                                        return;
                                      }
                                      if (!isValidPassword(password)) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Password minimal 6 karakter",
                                            ),
                                          ),
                                        );
                                        return;
                                      }
                                      // Panggil login pada LoginCubit
                                      context.read<LoginCubit>().login(
                                        email,
                                        password,
                                      );
                                    },
                            child:
                                state is LoginLoading
                                    ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                    : Text('Login'),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        icon: Image.asset(
                          'assets/icon/home/icons-google.png',
                          height: 24,
                        ),
                        label: const Text('Login dengan Google'),
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: 'Belum punya akun? ',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: AppFont.fontFamily,
                            color:
                                Theme.of(context).textTheme.bodyLarge?.color ??
                                Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: 'Daftar',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: AppFont.fontFamily,
                                color: Color(0xff0E592C),
                                decoration: TextDecoration.underline,
                              ),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () {
                                      context.go('/register');
                                    },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
