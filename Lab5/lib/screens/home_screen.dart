import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../models/movie.dart';
import '../widgets/movie_card.dart';
import 'movie_detail_screen.dart';

/// HomeScreen displays a scrollable list of movies.
///
/// Lab requirement:
/// - Home Screen must show movie poster, title, and rating.
/// - The movie list must be scrollable.
/// - When a movie is tapped, navigate to MovieDetailScreen.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// StatefulWidget is used here because we implement the optional search bar.
///
/// If we do not need search, this screen could be StatelessWidget.
class _HomeScreenState extends State<HomeScreen> {
  String searchText = '';

  /// Returns movies filtered by searchText.
  ///
  /// This is an optional enhancement from the lab.
  /// The user can search movie by title.
  List<Movie> get filteredMovies {
    if (searchText.trim().isEmpty) {
      return sampleMovies;
    }

    return sampleMovies.where((movie) {
      return movie.title.toLowerCase().contains(
        searchText.toLowerCase(),
      );
    }).toList();
  }

  /// Navigates to the MovieDetailScreen and passes the selected Movie object.
  ///
  /// This uses Navigator.push + MaterialPageRoute,
  /// which is one of the navigation methods required by the lab.
  void openMovieDetail(Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MovieDetailScreen(movie: movie),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final movies = filteredMovies;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Search bar is optional, but it makes the app more useful.
          TextField(
            decoration: const InputDecoration(
              hintText: 'Search movies...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
          ),

          const SizedBox(height: 16),

          if (movies.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text('No movies found.'),
              ),
            )
          else
          // List.generate creates a list of MovieCard widgets.
          // Each card receives one movie object and navigation callback.
            ...movies.map(
                  (movie) => MovieCard(
                movie: movie,
                onTap: () => openMovieDetail(movie),
              ),
            ),
        ],
      ),
    );
  }
}