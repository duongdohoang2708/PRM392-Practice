import 'package:flutter/material.dart';

import '../models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),

      child: ListTile(
        leading: Image.network(
          movie.imageUrl,

          width: 60,

          height: 90,

          fit: BoxFit.cover,

          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 60,

              height: 90,

              color: Colors.grey,

              child: const Icon(Icons.movie),
            );
          },
        ),

        title: Text(movie.title),

        subtitle: Row(
          children: [
            const Icon(Icons.star, color: Colors.orange, size: 18),

            Text(movie.rating.toString()),
          ],
        ),
      ),
    );
  }
}
