import 'package:flutter/material.dart';

import 'screens/login_screen.dart';

void main() {
  runApp(const MockLoginApp());
}

class MockLoginApp extends StatelessWidget {
  const MockLoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: "Lab10 Mock Login",

      theme: ThemeData(useMaterial3: true),

      home: const LoginScreen(),
    );
  }
}
