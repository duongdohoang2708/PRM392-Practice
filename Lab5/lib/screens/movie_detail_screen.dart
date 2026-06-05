import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../widgets/action_button.dart';
import '../widgets/genre_chip.dart';

/// MovieDetailScreen displays the selected movie information.
///
/// Lab requirement:
/// - Poster hero banner with gradient
/// - Title and genres as chips
/// - Overview text
/// - Action buttons: Favorite, Rate, Share
/// - List of trailers
/// - Scrollable layout
class MovieDetailScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailScreen({
    super.key,
    required this.movie,
  });

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

/// StatefulWidget is used because the Favorite button changes state.
class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool isFavorite = false;

  /// Toggles the favorite state.
  ///
  /// This is an optional enhancement from the lab.
  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite
              ? 'Added to favorites'
              : 'Removed from favorites',
        ),
      ),
    );
  }

  /// Shows a simple message when the user taps Rate.
  void rateMovie() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Rate feature clicked'),
      ),
    );
  }

  /// Shows a simple message when the user taps Share.
  void shareMovie() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Share feature clicked'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),

      // SingleChildScrollView makes the detail page scrollable.
      // This is important because the content may be taller than the screen.
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroBanner(movie),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleAndRating(movie),

                  const SizedBox(height: 12),

                  _buildGenreChips(movie),

                  const SizedBox(height: 20),

                  _buildOverview(movie),

                  const SizedBox(height: 20),

                  _buildActionButtons(),

                  const SizedBox(height: 24),

                  _buildTrailerSection(movie),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the poster banner at the top of the detail screen.
  ///
  /// Stack is used because we need to place:
  /// - Image
  /// - Gradient overlay
  /// - Movie title text
  /// on top of each other.
  Widget _buildHeroBanner(Movie movie) {
    return SizedBox(
      height: 240,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Hero(
            tag: 'movie-poster-${movie.id}',
            child: Image.network(
              movie.posterUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey.shade300,
                  child: const Icon(
                    Icons.broken_image,
                    size: 48,
                  ),
                );
              },
            ),
          ),

          // Gradient overlay improves text readability on top of image.
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black87,
                ],
              ),
            ),
          ),

          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Text(
              movie.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds movie title and rating row.
  Widget _buildTitleAndRating(Movie movie) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            movie.title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(width: 12),

        Row(
          children: [
            const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            const SizedBox(width: 4),
            Text(
              movie.rating.toString(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ],
    );
  }

  /// Builds genre chips using Wrap.
  ///
  /// Wrap is better than Row here because genres may overflow horizontally.
  /// If there is not enough width, Wrap automatically moves chips to a new line.
  Widget _buildGenreChips(Movie movie) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: movie.genres
          .map(
            (genre) => GenreChip(genre: genre),
      )
          .toList(),
    );
  }

  /// Builds the overview section.
  Widget _buildOverview(Movie movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          movie.overview,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  /// Builds Favorite, Rate, and Share buttons.
  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ActionButton(
          icon: isFavorite ? Icons.favorite : Icons.favorite_border,
          label: 'Favorite',
          color: isFavorite ? Colors.red : null,
          onPressed: toggleFavorite,
        ),
        ActionButton(
          icon: Icons.star_border,
          label: 'Rate',
          onPressed: rateMovie,
        ),
        ActionButton(
          icon: Icons.share,
          label: 'Share',
          onPressed: shareMovie,
        ),
      ],
    );
  }

  /// Builds the trailer list section.
  ///
  /// Because the whole screen is already inside SingleChildScrollView,
  /// we should not use a normal scrolling ListView here.
  ///
  /// Instead:
  /// - shrinkWrap: true makes ListView take only the height it needs.
  /// - NeverScrollableScrollPhysics disables inner scrolling.
  Widget _buildTrailerSection(Movie movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trailers',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: movie.trailers.length,
          itemBuilder: (context, index) {
            final trailer = movie.trailers[index];

            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.play_circle_fill),
              title: Text(trailer.title),
              subtitle: Text(trailer.duration),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Playing ${trailer.title}'),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}