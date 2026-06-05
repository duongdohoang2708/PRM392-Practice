import 'package:flutter/material.dart';

import 'screens/home_menu_screen.dart';

void main() {
  // The main() function is the entry point of every Flutter application.
  // runApp() tells Flutter which widget should be displayed first.
  runApp(const Lab4App());
}

/// Lab4App is the root widget of the whole application.
///
/// This widget is StatefulWidget because Exercise 4 needs to switch
/// between light mode and dark mode.
///
/// In a real app, global settings such as theme mode are usually managed
/// near the root widget, so all screens can use the same theme state.
class Lab4App extends StatefulWidget {
  const Lab4App({super.key});

  @override
  State<Lab4App> createState() => _Lab4AppState();
}

class _Lab4AppState extends State<Lab4App> {
  // This variable stores the current theme mode.
  // false means light mode.
  // true means dark mode.
  bool isDarkMode = false;

  /// Updates the app theme mode.
  ///
  /// setState() is required because the UI must rebuild after this value changes.
  void toggleTheme(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 4 - Flutter UI Fundamentals',
      debugShowCheckedModeBanner: false,

      // Light theme configuration.
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),

      // Dark theme configuration.
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),

      // Selects the active theme based on isDarkMode.
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,

      // HomeMenuScreen receives the theme state and callback
      // so Exercise 4 can toggle the global theme.
      home: HomeMenuScreen(
        isDarkMode: isDarkMode,
        onThemeChanged: toggleTheme,
      ),
    );
  }
}