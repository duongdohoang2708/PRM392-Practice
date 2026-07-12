import 'package:flutter/material.dart';

import '../services/notification_service.dart';

import '../widgets/notification_button.dart';

/// Main screen.
///
/// User interaction:
///
/// Button click
///
/// ↓
///
/// NotificationService
///
/// ↓
///
/// Android Notification
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationService = NotificationService();

    return Scaffold(
      appBar: AppBar(title: const Text("Notification Demo")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Center(
          child: NotificationButton(
            onPressed: () async {
              await notificationService.showNotification(
                title: "Login Successful",

                body: "Welcome back! Have a nice day.",
              );
            },
          ),
        ),
      ),
    );
  }
}
