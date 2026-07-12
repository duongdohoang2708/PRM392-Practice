/// Movie model represents a TV show returned from TVMaze API.
///
/// This class converts JSON data from the API
/// into a Dart object that Flutter can use.
class Movie {
  final int id;

  final String title;

  final String overview;

  final String imageUrl;

  final double rating;

  const Movie({
    required this.id,

    required this.title,

    required this.overview,

    required this.imageUrl,

    required this.rating,
  });

  /// Factory constructor converts JSON Map into Movie object.
  ///
  /// TVMaze response example:
  ///
  /// {
  ///   "id":1,
  ///   "name":"Breaking Bad",
  ///   "rating":{
  ///       "average":9.5
  ///   }
  /// }
  ///
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,

      title: json['name'] ?? 'Unknown',

      overview: _removeHtml(json['summary'] ?? 'No description available'),

      imageUrl: json['image'] != null ? json['image']['medium'] : '',

      rating: json['rating'] != null && json['rating']['average'] != null
          ? (json['rating']['average']).toDouble()
          : 0.0,
    );
  }

  /// TVMaze summary contains HTML tags.
  ///
  /// Example:
  ///
  /// "<p>A detective <b>solves</b> crimes</p>"
  ///
  /// Flutter Text widget cannot display HTML directly,
  /// so we remove tags before showing.
  static String _removeHtml(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>'), '');
  }
}
