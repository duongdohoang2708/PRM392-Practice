import 'package:flutter/material.dart';

import 'services/notification_service.dart';

import 'screens/home_screen.dart';

final NotificationService notificationService = NotificationService();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await notificationService.initialize();

  runApp(const NotificationApp());
}

class NotificationApp extends StatelessWidget {
  const NotificationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: "Lab10 Notification",

      theme: ThemeData(useMaterial3: true),

      home: const HomeScreen(),
    );
  }
}
