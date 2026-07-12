import 'package:flutter/material.dart';

import '../services/auth_api_service.dart';

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

  final AuthApiService authService = AuthApiService();

  bool isLoading = false;

  String? errorMessage;

  Future<void> login() async {
    setState(() {
      isLoading = true;

      errorMessage = null;
    });

    try {
      final user = await authService.login(
        username: usernameController.text.trim(),

        password: passwordController.text.trim(),
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,

        MaterialPageRoute(builder: (context) => HomeScreen(user: user)),
      );
    } catch (error) {
      setState(() {
        errorMessage = error.toString().replaceFirst("Exception:", "");
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("API Login")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            CustomTextField(label: "Username", controller: usernameController),

            const SizedBox(height: 16),

            CustomTextField(
              label: "Password",

              controller: passwordController,

              obscureText: true,
            ),

            const SizedBox(height: 20),

            if (errorMessage != null)
              Text(errorMessage!, style: const TextStyle(color: Colors.red)),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: isLoading ? null : login,

                child: isLoading
                    ? const SizedBox(
                        height: 20,

                        width: 20,

                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text("Login"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();

    passwordController.dispose();

    super.dispose();
  }
}
