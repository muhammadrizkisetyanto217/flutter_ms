import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ms/core/themes/app_theme.dart';
import 'package:flutter_ms/core/themes/theme-cubit.dart';
// import 'package:flutter_ms/presentation/user/homepage/main/home.dart';
import 'package:flutter_ms/routes/router.dart'; // import router

void main() {
  runApp(BlocProvider(create: (_) => ThemeCubit(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp.router(
          title: 'Aplikasi Saya',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        );
      },
    );
  }
}
