import 'package:flutter/material.dart';

import '../models/movie.dart';

/// MovieCard displays one movie item on the HomeScreen.
///
/// It shows:
/// - Movie poster
/// - Movie title
/// - Rating
/// - Genres
/// - Arrow icon
///
/// When tapped, it calls onTap to navigate to the detail screen.
class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const MovieCard({
    super.key,
    required this.movie,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        // InkWell gives a ripple effect when the card is tapped.
        onTap: onTap,

        child: Padding(
          padding: const EdgeInsets.all(12),

          child: Row(
            children: [
              // Hero creates a shared animation between list poster
              // and detail screen poster.
              Hero(
                tag: 'movie-poster-${movie.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    movie.posterUrl,
                    width: 70,
                    height: 90,
                    fit: BoxFit.cover,

                    // errorBuilder prevents the app from crashing
                    // if the image URL cannot be loaded.
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 70,
                        height: 90,
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.broken_image),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(width: 14),

              // Expanded allows the text column to use remaining width
              // and prevents horizontal overflow.
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          movie.rating.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Text(
                      movie.genres.join(', '),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),

              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}