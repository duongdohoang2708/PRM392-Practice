import 'package:flutter/material.dart';

import '../models/user.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            const Icon(Icons.check_circle, size: 80, color: Colors.green),

            const SizedBox(height: 20),

            Text(
              "Login successful",

              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: 10),

            Text(user.email),

            const SizedBox(height: 10),

            Text("Token: ${user.token}"),
          ],
        ),
      ),
    );
  }
}
