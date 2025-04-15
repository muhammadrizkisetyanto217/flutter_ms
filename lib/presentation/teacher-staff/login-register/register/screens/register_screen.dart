import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_ms/core/constants/app_font.dart';
import 'package:flutter_ms/presentation/component/main/fontsize.dart';
import 'package:flutter_ms/presentation/component/user/input_user_component.dart';
import 'package:flutter_ms/presentation/teacher-staff/login-register/register/cubit/register_cubit.dart';
import 'package:flutter_ms/presentation/teacher-staff/login-register/register/cubit/register_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.addListener(_onFormChanged);
    emailController.addListener(_onFormChanged);
    passwordController.addListener(_onFormChanged);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onFormChanged() {
    setState(() {}); // update tampilan saat user mengetik
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool isValidPassword(String password) {
    return password.length >= 6;
  }

  bool isFormValid() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    return name.isNotEmpty && isValidEmail(email) && isValidPassword(password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                CustomText22(text: "Daftar Akun Baru sekarang"),
                const SizedBox(height: 16),
                Text(
                  "Masukkan data lengkap untuk membuat akun.",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                InputUser(
                  controller: nameController,
                  hintText: 'Nama Lengkap',
                  icon: Icons.person,
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

                const SizedBox(height: 20),

                BlocConsumer<RegisterCubit, RegisterState>(
                  listener: (context, state) {
                    print("State changed to: $state");

                    if (state is RegisterFailure) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    } else if (state is RegisterSuccess) {
                      print("Register sukses, mencoba go ke /home");

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Registrasi berhasil. Silakan login."),
                        ),
                      );

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        GoRouter.of(context).go('/home');
                      });
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isFormValid()
                                  ? const Color(0xff0E592C)
                                  : Colors.grey.shade400,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed:
                            (state is RegisterLoading || !isFormValid())
                                ? null
                                : () {
                                  final name = nameController.text.trim();
                                  final email = emailController.text.trim();
                                  final password = passwordController.text;

                                  if (name.isEmpty ||
                                      email.isEmpty ||
                                      password.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Semua field wajib diisi",
                                        ),
                                      ),
                                    );
                                    return;
                                  }

                                  if (!isValidEmail(email)) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Format email tidak valid",
                                        ),
                                      ),
                                    );
                                    return;
                                  }

                                  if (!isValidPassword(password)) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Password minimal 6 karakter",
                                        ),
                                      ),
                                    );
                                    return;
                                  }

                                  context.read<RegisterCubit>().register(
                                    name,
                                    email,
                                    password,
                                  );
                                },
                        child:
                            state is RegisterLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text('Daftar'),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () => context.go('/login'),
                    child: Text(
                      "Sudah punya akun? Login",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: AppFont.fontFamily,
                        color: Color(0xff0E592C),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
