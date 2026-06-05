import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const OnboardingDemoApp());
}

class OnboardingDemoApp extends StatelessWidget {
  const OnboardingDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onboarding Demo',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const SplashScreen(),
    );
  }
}