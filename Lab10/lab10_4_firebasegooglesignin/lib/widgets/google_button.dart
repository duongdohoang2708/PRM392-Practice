import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,

      child: ElevatedButton.icon(
        icon: const Icon(Icons.login),

        label: const Text("Sign in with Google"),

        onPressed: onPressed,
      ),
    );
  }
}
