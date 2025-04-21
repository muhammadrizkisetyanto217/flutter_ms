// import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ms/presentation/teacher-staff/homepage/attendance/detail/cubit/kajian_attendance_cubit.dart';
import 'package:flutter_ms/presentation/teacher-staff/homepage/attendance/detail/service/kajian_attendance_service.dart';
import 'package:flutter_ms/presentation/teacher-staff/login-register/login/cubit/login_cubit.dart';
import 'package:flutter_ms/presentation/teacher-staff/login-register/login/service/auth_service.dart';
import 'package:flutter_ms/presentation/teacher-staff/login-register/register/cubit/register_cubit.dart';
import 'package:flutter_ms/presentation/teacher-staff/login-register/register/service/auth_service.dart';
import 'package:go_router/go_router.dart';
import 'pages_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', redirect: (_, __) => '/login'),
    GoRoute(
      path: '/login',
      builder:
          (context, state) => BlocProvider(
            create: (_) => LoginCubit(AuthServiceLogin()),
            child: const LoginScreen(),
          ),
    ),
    GoRoute(
      path: '/register',
      builder:
          (context, state) => BlocProvider(
            create: (_) => RegisterCubit(AuthServiceRegister()),
            child: const RegisterScreen(),
          ),
    ),

    // ✅ /home sebagai induk
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
      routes: [
        // ✅ /home/attendance
        GoRoute(
          path: 'attendance',
          builder: (context, state) => AbsensiScreen(),
          routes: [
            // ✅ /home/attendance/mylocation
            GoRoute(
              path: 'mylocation',
              builder:
                  (context, state) => BlocProvider(
                    create:
                        (_) => KajianAttendanceCubit(
                          KajianAttendanceService(
                            dio: Dio(
                              BaseOptions(
                                baseUrl:
                                    'https://quiz-fiber-production.up.railway.app/',
                              ),
                            ),
                          ),
                        ),
                    child: MyLocationScreen(),
                  ),
            ),
          ],
        ),
      ],
    ),
  ],
);
