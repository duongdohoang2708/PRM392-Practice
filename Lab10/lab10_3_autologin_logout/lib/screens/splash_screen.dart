import 'package:flutter/material.dart';

import '../services/storage_service.dart';

import 'login_screen.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final StorageService storage = StorageService();

  @override
  void initState() {
    super.initState();

    checkLogin();
  }

  Future<void> checkLogin() async {
    await Future.delayed(const Duration(seconds: 1));

    final loggedIn = await storage.isLoggedIn();

    if (!mounted) return;

    if (loggedIn) {
      final user = await storage.getUserSession();

      Navigator.pushReplacement(
        context,

        MaterialPageRoute(
          builder: (context) => HomeScreen(
            username: user["username"] ?? "",

            email: user["email"] ?? "",
          ),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,

        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
