import 'package:flutter/material.dart';

/// Exercise 4 - App Structure with Scaffold, AppBar, FAB & Theme
///
/// Required:
/// - Scaffold
/// - AppBar
/// - Body
/// - FloatingActionButton
/// - ThemeData
/// - Dark Mode toggle
class AppStructureThemeDemo extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const AppStructureThemeDemo({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar is the top section of the screen.
      appBar: AppBar(
        title: const Text('Exercise 4 - App Structure'),

        // actions appear on the right side of the AppBar.
        actions: [
          Row(
            children: [
              const Text('Dark'),

              // This Switch changes the global theme.
              // The state is stored in main.dart, not in this screen.
              Switch(
                value: isDarkMode,
                onChanged: onThemeChanged,
              ),
            ],
          ),
        ],
      ),

      // Body is the main content area.
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'This is a simple screen with Scaffold, AppBar, Body, FloatingActionButton and ThemeData.',
            textAlign: TextAlign.center,
          ),
        ),
      ),

      // FloatingActionButton is used for the main action of a screen.
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('FAB clicked')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}