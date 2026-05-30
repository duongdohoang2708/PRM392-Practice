import 'package:flutter/material.dart';

import '../data/sample_books.dart';
import 'chapter_list_screen.dart';

class BookListScreen extends StatelessWidget {
  const BookListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Reader'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: sampleBooks.length,
        itemBuilder: (context, index) {
          final book = sampleBooks[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(book.title[0]),
              ),
              title: Text(book.title),
              subtitle: Text('${book.author}\n${book.description}'),
              isThreeLine: true,
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChapterListScreen(book: book),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}