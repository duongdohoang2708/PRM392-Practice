import 'package:flutter/material.dart';

import '../services/firebase_auth_service.dart';

import '../widgets/google_button.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuthService service = FirebaseAuthService();

  bool loading = false;

  Future<void> login() async {
    setState(() {
      loading = true;
    });

    final user = await service.signInWithGoogle();

    if (!mounted) return;

    setState(() {
      loading = false;
    });

    if (user != null) {
      Navigator.pushReplacement(
        context,

        MaterialPageRoute(builder: (_) => HomeScreen(user: user)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: loading
              ? const CircularProgressIndicator()
              : GoogleButton(onPressed: login),
        ),
      ),
    );
  }
}
