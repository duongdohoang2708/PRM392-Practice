import 'package:flutter/material.dart';

import '../services/storage_service.dart';

import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  final String username;

  final String email;

  const HomeScreen({super.key, required this.username, required this.email});

  @override
  Widget build(BuildContext context) {
    final storage = StorageService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),

        actions: [
          IconButton(
            icon: const Icon(Icons.logout),

            onPressed: () async {
              await storage.logout();

              if (!context.mounted) return;

              Navigator.pushReplacement(
                context,

                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [Text("Welcome $username"), Text(email)],
        ),
      ),
    );
  }
}
