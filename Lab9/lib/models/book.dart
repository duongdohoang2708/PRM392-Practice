/// Book model represents one book item.
///
/// This class converts JSON data into Dart object
/// and converts Dart object back to JSON.
class Book {
  final int id;

  final String title;

  final String author;

  final String category;

  Book({
    required this.id,

    required this.title,

    required this.author,

    required this.category,
  });

  /// Convert JSON Map into Book object.
  ///
  /// Example:
  ///
  /// {
  ///  "id":1,
  ///  "title":"Clean Code"
  /// }
  ///
  /// becomes:
  ///
  /// Book(...)
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],

      title: json['title'],

      author: json['author'],

      category: json['category'],
    );
  }

  /// Convert Book object into JSON.
  ///
  /// Used before saving data to local file.
  Map<String, dynamic> toJson() {
    return {"id": id, "title": title, "author": author, "category": category};
  }
}
