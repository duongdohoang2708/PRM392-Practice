import 'package:flutter/material.dart';

import '../widgets/menu_card.dart';
import 'core_widgets_demo.dart';
import 'input_controls_demo.dart';
import 'layout_demo.dart';
import 'app_structure_theme_demo.dart';
import 'common_ui_fixes_demo.dart';

/// HomeMenuScreen displays all 5 exercises in one menu.
///
/// This screen helps us keep one Flutter project while still separating
/// each exercise into its own screen file.
class HomeMenuScreen extends StatelessWidget {
  final bool isDarkMode;

  // This callback comes from Lab4App.
  // It allows Exercise 4 to change the global theme.
  final ValueChanged<bool> onThemeChanged;

  const HomeMenuScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 4 - Flutter UI Fundamentals'),
      ),

      // ListView is used because the menu can scroll if there are many items.
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const MenuCard(
            title: 'Exercise 1 - Core Widgets Demo',
            screen: CoreWidgetsDemo(),
          ),

          const MenuCard(
            title: 'Exercise 2 - Input Controls Demo',
            screen: InputControlsDemo(),
          ),

          const MenuCard(
            title: 'Exercise 3 - Layout Demo',
            screen: LayoutDemo(),
          ),

          MenuCard(
            title: 'Exercise 4 - App Structure & Theme',
            screen: AppStructureThemeDemo(
              isDarkMode: isDarkMode,
              onThemeChanged: onThemeChanged,
            ),
          ),

          const MenuCard(
            title: 'Exercise 5 - Common UI Fixes',
            screen: CommonUiFixesDemo(),
          ),
        ],
      ),
    );
  }
}