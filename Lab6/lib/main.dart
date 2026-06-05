import 'package:flutter/material.dart';

void main() {
  // Entry point of the Flutter application.
  // runApp() tells Flutter to display ResponsiveMovieApp as the root widget.
  runApp(const ResponsiveMovieApp());
}

/// Root widget of Lab 6.
///
/// This app demonstrates:
/// - Responsive UI
/// - Search filtering
/// - Genre chip filtering
/// - Sort dropdown
/// - List layout for small screens
/// - Grid layout for wider screens
class ResponsiveMovieApp extends StatelessWidget {
  const ResponsiveMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 6 - Responsive Movie Genre',
      debugShowCheckedModeBanner: false,

      // Global theme for the whole app.
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),

      home: const GenreScreen(),
    );
  }
}

/// Movie model.
///
/// This class represents one movie item in the app.
/// The lab requires static sample data, so we create a simple model
/// instead of calling an API.
class Movie {
  final String title;
  final int year;
  final List<String> genres;
  final String posterUrl;
  final double rating;

  const Movie({
    required this.title,
    required this.year,
    required this.genres,
    required this.posterUrl,
    required this.rating,
  });
}

/// Static sample movie data.
///
/// In a real project, this data may come from:
/// - REST API
/// - local database
/// - Firebase
///
/// In this lab, we use static data because the requirement says
/// no API call is needed.
const List<Movie> allMovies = [
  Movie(
    title: 'Dune: Part Two',
    year: 2024,
    genres: ['Sci-Fi', 'Adventure', 'Drama'],
    posterUrl: 'https://picsum.photos/seed/dune/300/450',
    rating: 8.6,
  ),
  Movie(
    title: 'Deadpool & Wolverine',
    year: 2024,
    genres: ['Action', 'Comedy'],
    posterUrl: 'https://picsum.photos/seed/deadpool/300/450',
    rating: 8.3,
  ),
  Movie(
    title: 'Inside Out 2',
    year: 2024,
    genres: ['Animation', 'Comedy', 'Family'],
    posterUrl: 'https://picsum.photos/seed/insideout/300/450',
    rating: 7.9,
  ),
  Movie(
    title: 'Interstellar',
    year: 2014,
    genres: ['Sci-Fi', 'Drama'],
    posterUrl: 'https://picsum.photos/seed/interstellar/300/450',
    rating: 8.7,
  ),
  Movie(
    title: 'The Batman',
    year: 2022,
    genres: ['Action', 'Crime', 'Drama'],
    posterUrl: 'https://picsum.photos/seed/batman/300/450',
    rating: 7.8,
  ),
  Movie(
    title: 'La La Land',
    year: 2016,
    genres: ['Drama', 'Music', 'Romance'],
    posterUrl: 'https://picsum.photos/seed/lalaland/300/450',
    rating: 8.0,
  ),
];

/// List of available genres.
///
/// These genres are shown as selectable chips.
const List<String> availableGenres = [
  'Action',
  'Adventure',
  'Animation',
  'Comedy',
  'Crime',
  'Drama',
  'Family',
  'Music',
  'Romance',
  'Sci-Fi',
];

/// Main screen of Lab 6.
///
/// This screen is StatefulWidget because:
/// - searchQuery changes when the user types
/// - selectedGenres changes when the user taps chips
/// - selectedSort changes when the user selects a sort option
class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  // Stores the current search text.
  String searchQuery = '';

  // Stores selected genres.
  //
  // Set is used instead of List because:
  // - each genre should appear only once
  // - checking whether a genre is selected is easy with contains()
  final Set<String> selectedGenres = {};

  // Stores the current sort option.
  String selectedSort = 'A-Z';

  /// Returns the movie list after applying search, genre filtering, and sorting.
  ///
  /// This is a computed getter.
  /// Every time build() runs, this getter calculates the latest visible movies
  /// based on the current user input.
  List<Movie> get visibleMovies {
    // Step 1: filter movies by search query and selected genres.
    final filtered = allMovies.where((movie) {
      // Search should be case-insensitive.
      final matchesSearch = movie.title.toLowerCase().contains(
        searchQuery.toLowerCase().trim(),
      );

      // If no genre is selected, all genres are accepted.
      //
      // If at least one genre is selected, the movie must have at least
      // one genre that exists in selectedGenres.
      final matchesGenre = selectedGenres.isEmpty ||
          movie.genres.any((genre) => selectedGenres.contains(genre));

      return matchesSearch && matchesGenre;
    }).toList();

    // Step 2: sort the filtered result.
    //
    // sort() changes the list directly, so we sort the copied list,
    // not the original allMovies list.
    switch (selectedSort) {
      case 'A-Z':
        filtered.sort((a, b) => a.title.compareTo(b.title));
        break;

      case 'Z-A':
        filtered.sort((a, b) => b.title.compareTo(a.title));
        break;

      case 'Year':
        filtered.sort((a, b) => b.year.compareTo(a.year));
        break;

      case 'Rating':
        filtered.sort((a, b) => b.rating.compareTo(a.rating));
        break;
    }

    return filtered;
  }

  /// Toggles a genre chip.
  ///
  /// If the genre is already selected, remove it.
  /// If the genre is not selected, add it.
  void toggleGenre(String genre) {
    setState(() {
      if (selectedGenres.contains(genre)) {
        selectedGenres.remove(genre);
      } else {
        selectedGenres.add(genre);
      }
    });
  }

  /// Clears all filters and resets sorting.
  ///
  /// This is an optional enhancement, but it is useful for testing.
  void clearFilters() {
    setState(() {
      searchQuery = '';
      selectedGenres.clear();
      selectedSort = 'A-Z';
    });
  }

  @override
  Widget build(BuildContext context) {
    final movies = visibleMovies;

    // MediaQuery reads screen information.
    // Here we use it to adjust horizontal padding depending on screen width.
    final screenWidth = MediaQuery.of(context).size.width;

    final horizontalPadding = screenWidth >= 800 ? 32.0 : 16.0;

    return Scaffold(
      body: SafeArea(
        // SafeArea prevents the UI from being hidden behind notches,
        // camera cutouts, or system status bars.
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: 16,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroHeading(context),

              const SizedBox(height: 16),

              _buildSearchBar(),

              const SizedBox(height: 16),

              _buildGenreSection(),

              const SizedBox(height: 16),

              _buildSortBar(movies.length),

              const SizedBox(height: 16),

              // Expanded gives the movie list the remaining vertical space.
              // Without Expanded, ListView/GridView inside Column can cause
              // layout errors because it does not know its height.
              Expanded(
                child: _buildResponsiveMovieArea(movies),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the title heading section.
  ///
  /// LayoutBuilder reads the available width of this widget.
  /// We use it to change the heading style on wide screens.
  Widget _buildHeroHeading(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 800;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(isWide ? 24 : 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Find a Movie',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                isWide
                    ? 'Browse movies by genre, search by title, and sort results in a responsive tablet layout.'
                    : 'Search, filter, and sort your favorite movies.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        );
      },
    );
  }

  /// Builds the search bar.
  ///
  /// The lab requires a search bar that filters movie titles
  /// using case-insensitive matching.
  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search movies...',
        prefixIcon: const Icon(Icons.search),

        // Show a clear icon only when searchQuery is not empty.
        suffixIcon: searchQuery.isEmpty
            ? null
            : IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            setState(() {
              searchQuery = '';
            });
          },
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      onChanged: (value) {
        setState(() {
          searchQuery = value;
        });
      },
    );
  }

  /// Builds genre chips using Wrap.
  ///
  /// Wrap is required by the lab because it automatically moves chips
  /// to the next line when there is not enough horizontal space.
  Widget _buildGenreSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Genres',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(width: 8),

            // Optional enhancement:
            // show number of selected genres as a small badge.
            if (selectedGenres.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                child: Text(
                  '${selectedGenres.length} selected',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
          ],
        ),

        const SizedBox(height: 8),

        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: availableGenres.map((genre) {
            final isSelected = selectedGenres.contains(genre);

            return FilterChip(
              label: Text(genre),
              selected: isSelected,
              onSelected: (_) => toggleGenre(genre),
            );
          }).toList(),
        ),
      ],
    );
  }

  /// Builds sort dropdown and result count.
  Widget _buildSortBar(int resultCount) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '$resultCount movies found',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),

        if (searchQuery.isNotEmpty || selectedGenres.isNotEmpty)
          TextButton(
            onPressed: clearFilters,
            child: const Text('Clear filters'),
          ),

        const SizedBox(width: 8),

        DropdownButton<String>(
          value: selectedSort,
          items: const [
            DropdownMenuItem(
              value: 'A-Z',
              child: Text('A-Z'),
            ),
            DropdownMenuItem(
              value: 'Z-A',
              child: Text('Z-A'),
            ),
            DropdownMenuItem(
              value: 'Year',
              child: Text('Year'),
            ),
            DropdownMenuItem(
              value: 'Rating',
              child: Text('Rating'),
            ),
          ],
          onChanged: (value) {
            if (value == null) return;

            setState(() {
              selectedSort = value;
            });
          },
        ),
      ],
    );
  }

  /// Builds the responsive movie list/grid area.
  ///
  /// LayoutBuilder gives the available width of this area.
  ///
  /// Requirement:
  /// - If width < 800: use one-column ListView
  /// - If width >= 800: use two-column GridView
  Widget _buildResponsiveMovieArea(List<Movie> movies) {
    if (movies.isEmpty) {
      return const Center(
        child: Text('No movies match your filters.'),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 800;

        if (isWide) {
          return GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 3.2,
            children: movies.map((movie) {
              return MovieCard(movie: movie);
            }).toList(),
          );
        }

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: MovieCard(movie: movies[index]),
            );
          },
        );
      },
    );
  }
}

/// MovieCard displays one movie item.
///
/// It is used in both:
/// - ListView on small screens
/// - GridView on wide screens
class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // The card adapts internally based on its own width.
        //
        // This is a component-level responsive technique.
        // It means the MovieCard does not only depend on full screen width,
        // but also on the width given by its parent.
        final isCompact = constraints.maxWidth < 420;

        final posterWidth = isCompact ? 82.0 : 100.0;
        final posterHeight = isCompact ? 120.0 : 135.0;

        return Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${movie.title} selected'),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      movie.posterUrl,
                      width: posterWidth,
                      height: posterHeight,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: posterWidth,
                          height: posterHeight,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.broken_image),
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          movie.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                          Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          '${movie.year}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),

                        const SizedBox(height: 6),

                        Text(
                          movie.genres.join(', '),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),

                        const SizedBox(height: 8),

                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 18,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              movie.rating.toString(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}