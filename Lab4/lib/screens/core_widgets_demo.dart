import 'package:flutter/material.dart';

/// Exercise 1 - Core Widgets
///
/// Required widgets:
/// - Text
/// - Image
/// - Icon
/// - Card
/// - ListTile
///
/// This screen demonstrates basic display widgets in Flutter.
class CoreWidgetsDemo extends StatelessWidget {
  const CoreWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold provides the basic structure of a Material screen.
      appBar: AppBar(
        title: const Text('Exercise 1 - Core Widgets'),
      ),

      // ListView is used instead of Column because it can scroll
      // when the content is taller than the screen.
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Text widget displays a string on the screen.
          // TextStyle customizes font size, weight, color, etc.
          const Text(
            'Welcome to Flutter UI',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          // Icon displays an icon from Flutter Material Icons.
          const Icon(
            Icons.movie,
            size: 64,
            color: Colors.blue,
          ),

          const SizedBox(height: 16),

          // ClipRRect gives rounded corners to the image.
          ClipRRect(
            borderRadius: BorderRadius.circular(12),

            // Image.network loads an image from the internet.
            // BoxFit.cover makes the image fill the area while keeping ratio.
            child: Image.network(
              'https://picsum.photos/600/300',
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 16),

          // Card groups information inside a Material-style container.
          Card(
            // ListTile is commonly used to display one row of information.
            child: ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Movie Item'),
              subtitle: const Text('This is a sample ListTile inside a Card.'),
              trailing: const Icon(Icons.chevron_right),

              // Shows a temporary message when the item is tapped.
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Movie item tapped')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}