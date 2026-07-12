import 'package:flutter/material.dart';

import '../models/book.dart';

/// BookCard displays one book item.
///
/// It provides:
/// - Book information
/// - Edit button
/// - Delete button
class BookCard extends StatelessWidget {
  final Book book;

  final VoidCallback onEdit;

  final VoidCallback onDelete;

  const BookCard({
    super.key,

    required this.book,

    required this.onEdit,

    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      child: ListTile(
        title: Text(book.title),

        subtitle: Text("${book.author}\n${book.category}"),

        isThreeLine: true,

        trailing: Row(
          mainAxisSize: MainAxisSize.min,

          children: [
            IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),

            IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
          ],
        ),
      ),
    );
  }
}
