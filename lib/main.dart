import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Saya',
      home: Scaffold(
        appBar: AppBar(title: Text('Aplikasi Saya')),
        body: Center(
          child: Text('Aplikasi Saya', style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}
