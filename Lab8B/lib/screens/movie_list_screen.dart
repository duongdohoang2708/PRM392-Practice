import 'package:flutter/material.dart';

import '../models/movie.dart';

import '../services/movie_service.dart';

import '../widgets/movie_card.dart';

class MovieListScreen extends StatelessWidget {
  const MovieListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = MovieService();

    return Scaffold(
      appBar: AppBar(title: const Text("Popular TV Show")),

      body: FutureBuilder<List<Movie>>(
        future: service.fetchMovies(),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  const Text("Something went wrong"),

                  ElevatedButton(
                    onPressed: () {
                      // Retry can be implemented
                      // by rebuilding FutureBuilder
                    },

                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }

          if (snapshot.hasData) {
            final movies = snapshot.data!;

            if (movies.isEmpty) {
              return const Center(child: Text("No movies found"));
            }

            return ListView.builder(
              itemCount: movies.length,

              itemBuilder: (context, index) {
                return MovieCard(movie: movies[index]);
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
