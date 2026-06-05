import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  // The main() function is the entry point of the Flutter application.
  // runApp() tells Flutter to display MovieApp as the root widget.
  runApp(const MovieApp());
}

/// MovieApp is the root widget of this lab project.
///
/// This app demonstrates:
/// - A movie list screen
/// - A movie detail screen
/// - Navigation using Navigator.push and MaterialPageRoute
/// - Passing a Movie object between screens
class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Detail App',

      // Removes the debug banner in the top-right corner.
      debugShowCheckedModeBanner: false,

      // Global app theme.
      // ThemeData controls the default colors, typography, and component styles.
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),

      // The first screen displayed when the app starts.
      home: const HomeScreen(),
    );
  }
}