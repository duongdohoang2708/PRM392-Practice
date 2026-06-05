import 'trailer.dart';

/// Movie model represents all information needed by the UI.
///
/// This object will be passed from HomeScreen to MovieDetailScreen.
/// Passing the whole Movie object is required by the lab.
class Movie {
  final int id;
  final String title;
  final String posterUrl;
  final String overview;
  final List<String> genres;
  final double rating;
  final List<Trailer> trailers;

  const Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.overview,
    required this.genres,
    required this.rating,
    required this.trailers,
  });
}