import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ms/core/themes/theme-cubit.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Aplikasi Saya'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_medium),
            onPressed: () {
              themeCubit.toggleTheme();
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Aplikasi Saya', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
