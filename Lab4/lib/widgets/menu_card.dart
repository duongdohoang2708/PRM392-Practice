import 'package:flutter/material.dart';

/// MenuCard is a reusable widget for the home menu.
///
/// It displays one exercise item as a Card + ListTile.
/// When the user taps it, the app navigates to the target screen.
///
/// Creating this separate widget helps avoid repeating the same
/// Card/ListTile code multiple times in HomeMenuScreen.
class MenuCard extends StatelessWidget {
  final String title;
  final Widget screen;

  const MenuCard({
    super.key,
    required this.title,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),

      // ListTile is a standard Material widget for list rows.
      // It provides title, subtitle, leading, trailing, and tap handling.
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),

        // Navigator.push() opens a new screen.
        // MaterialPageRoute creates a standard Material screen transition.
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => screen),
          );
        },
      ),
    );
  }
}