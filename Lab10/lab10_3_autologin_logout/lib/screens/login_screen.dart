import 'package:flutter/material.dart';

import '../services/auth_api_service.dart';

import '../services/storage_service.dart';

import '../widgets/custom_text_field.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final AuthApiService api = AuthApiService();

  final StorageService storage = StorageService();

  bool loading = false;

  String? error;

  Future<void> login() async {
    setState(() {
      loading = true;

      error = null;
    });

    try {
      final user = await api.login(
        username: usernameController.text,

        password: passwordController.text,
      );

      await storage.saveUserSession(
        token: user.token,

        username: user.username,

        email: user.email,
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,

        MaterialPageRoute(
          builder: (_) =>
              HomeScreen(username: user.username, email: user.email),
        ),
      );
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            CustomTextField(label: "Username", controller: usernameController),

            const SizedBox(height: 15),

            CustomTextField(
              label: "Password",

              controller: passwordController,

              obscureText: true,
            ),

            if (error != null)
              Text(error!, style: const TextStyle(color: Colors.red)),

            ElevatedButton(
              onPressed: loading ? null : login,

              child: loading
                  ? const CircularProgressIndicator()
                  : const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
