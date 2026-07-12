import 'package:flutter/material.dart';

import '../models/firebase_user.dart';

import '../services/firebase_auth_service.dart';

import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseUserModel user;

  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final service = FirebaseAuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),

        actions: [
          IconButton(
            icon: const Icon(Icons.logout),

            onPressed: () async {
              await service.logout();

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

          children: [
            CircleAvatar(
              radius: 40,

              backgroundImage: NetworkImage(user.photoUrl),
            ),

            Text(user.name),

            Text(user.email),
          ],
        ),
      ),
    );
  }
}
