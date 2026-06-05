import '../models/movie.dart';
import '../models/trailer.dart';

/// Static sample movie data.
///
/// The lab requires using static sample data instead of API calls.
/// In a real app, this data could come from a REST API or local database.
const List<Movie> sampleMovies = [
  Movie(
    id: 1,
    title: 'Dune: Part Two',
    posterUrl:
    'https://image.tmdb.org/t/p/w500/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg',
    rating: 8.6,
    genres: ['Sci-Fi', 'Adventure', 'Drama'],
    overview:
    'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
    trailers: [
      Trailer(title: 'Official Trailer #1', duration: '2:35'),
      Trailer(title: 'IMAX Sneak Peek', duration: '1:48'),
      Trailer(title: 'Final Trailer', duration: '2:21'),
    ],
  ),
  Movie(
    id: 2,
    title: 'Deadpool & Wolverine',
    posterUrl:
    'https://image.tmdb.org/t/p/w500/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg',
    rating: 8.3,
    genres: ['Action', 'Comedy'],
    overview:
    'Wade Wilson teams up with Wolverine for a chaotic mission that changes the Marvel universe forever.',
    trailers: [
      Trailer(title: 'Red Band Trailer', duration: '2:25'),
      Trailer(title: 'Behind the Scenes', duration: '3:10'),
      Trailer(title: 'Final Trailer', duration: '2:05'),
    ],
  ),
  Movie(
    id: 3,
    title: 'Inside Out 2',
    posterUrl:
    'https://image.tmdb.org/t/p/w500/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg',
    rating: 7.9,
    genres: ['Animation', 'Family', 'Comedy'],
    overview:
    'Riley enters her teenage years, and new emotions arrive to change everything inside her mind.',
    trailers: [
      Trailer(title: 'Official Trailer', duration: '2:12'),
      Trailer(title: 'Meet the New Emotions', duration: '1:45'),
      Trailer(title: 'Family Preview', duration: '2:00'),
    ],
  ),
];