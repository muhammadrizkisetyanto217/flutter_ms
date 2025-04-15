// import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ms/presentation/teacher-staff/login-register/login/cubit/login_cubit.dart';
import 'package:flutter_ms/presentation/teacher-staff/login-register/login/service/auth_service.dart';
import 'package:flutter_ms/presentation/teacher-staff/login-register/register/cubit/register_cubit.dart';
import 'package:flutter_ms/presentation/teacher-staff/login-register/register/service/auth_service.dart';
import 'package:go_router/go_router.dart';
import 'pages_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      redirect: (_, __) => '/login', // ⬅ redirect langsung ke login
    ),
    GoRoute(path: '/home', builder: (context, state) => HomePage()),
    GoRoute(path: '/mylocation', builder: (context, state) => MyLocationPage()),
    GoRoute(
      path: '/login',
      builder:
          (context, state) => BlocProvider(
            create:
                (_) => LoginCubit(
                  AuthServiceLogin(),
                ), // ⬅ langsung bikin instance di sini
            child: const LoginPage(),
          ),
    ),
    GoRoute(
      path: '/register',
      builder:
          (context, state) => BlocProvider(
            create:
                (_) => RegisterCubit(
                  AuthServiceRegister(),
                ), // ⬅ langsung bikin instance di sini
            child: const RegisterPage(),
          ),
    ),
  ],
);
