import 'package:flutter/material.dart';

/// Exercise 3 - Layout Composition
///
/// Required widgets:
/// - Column
/// - Row
/// - Padding
/// - ListView
///
/// This screen is designed like a simple movie home section.
class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});

  final List<String> movies = const [
    'Avatar',
    'Inception',
    'Interstellar',
    'Joker',
    'The Batman',
    'Dune: Part Two',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 3 - Layout Demo'),
      ),

      // Padding adds space around the whole screen content.
      body: Padding(
        padding: const EdgeInsets.all(16),

        // Column arranges widgets vertically.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row arranges widgets horizontally.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Now Playing',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                TextButton(
                  onPressed: () {},
                  child: const Text('See all'),
                ),
              ],
            ),

            const SizedBox(height: 12),

            const Text(
              'A simple sectioned layout using Column, Row, Padding, and ListView.builder.',
            ),

            const SizedBox(height: 16),

            // Important layout fix:
            // ListView inside Column needs a bounded height.
            // Expanded gives the ListView the remaining available space.
            Expanded(
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(movie[0]),
                      ),
                      title: Text(movie),
                      subtitle: const Text('Sample description'),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}