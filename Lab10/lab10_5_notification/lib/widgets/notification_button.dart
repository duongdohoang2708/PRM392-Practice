import 'package:flutter/material.dart';

/// Reusable button for triggering notification.
///
/// This widget does not know how notification works.
///
/// It only receives callback from parent widget.
class NotificationButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NotificationButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,

      child: ElevatedButton.icon(
        onPressed: onPressed,

        icon: const Icon(Icons.notifications),

        label: const Text("Show Notification"),
      ),
    );
  }
}
