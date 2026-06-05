/// Trailer model represents one trailer item of a movie.
///
/// In this lab, each movie has a list of trailers.
/// Example:
/// - Official Trailer #1
/// - IMAX Sneak Peek
/// - Final Trailer
class Trailer {
  final String title;
  final String duration;

  const Trailer({
    required this.title,
    required this.duration,
  });
}