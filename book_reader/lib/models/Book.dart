class Book {
  final String id;
  final String title;
  final String author;
  final String description;
  final List<Chapter> chapters;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.chapters,
  });
}

class Chapter {
  final String id;
  final String title;
  final String content;

  const Chapter({
    required this.id,
    required this.title,
    required this.content,
  });
}