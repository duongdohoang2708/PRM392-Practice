import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/movie.dart';

/// MovieService handles communication
/// between Flutter application and TVMaze API.
///
/// Responsibilities:
///
/// - Send HTTP request
/// - Receive JSON
/// - Decode JSON
/// - Convert JSON into Movie objects
///
/// UI never directly calls API.
class MovieService {
  final String apiUrl = "https://api.tvmaze.com/shows";

  Future<List<Movie>> fetchMovies() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);

        return jsonData.map((item) => Movie.fromJson(item)).toList();
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("Failed to load movies: $error");
    }
  }
}
