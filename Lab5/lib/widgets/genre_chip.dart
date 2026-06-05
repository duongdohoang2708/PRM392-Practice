import 'package:flutter/material.dart';

/// GenreChip displays one movie genre as a small chip.
///
/// Example:
/// - Action
/// - Comedy
/// - Sci-Fi
///
/// This widget is separated to keep MovieDetailScreen cleaner.
class GenreChip extends StatelessWidget {
  final String genre;

  const GenreChip({
    super.key,
    required this.genre,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(genre),
      visualDensity: VisualDensity.compact,
    );
  }
}