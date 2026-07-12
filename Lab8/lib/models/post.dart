/// Post model represents one item returned from API.
///
/// This class converts JSON data from server
/// into a Dart object that Flutter can understand.
///
/// Example:
///
/// JSON:
/// {
///   "id":1,
///   "title":"hello"
/// }
///
/// becomes:
///
/// Post(
///   id:1,
///   title:"hello"
/// )
class Post {

  final int userId;

  final int id;

  final String title;

  final String body;


  const Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });



  /// Factory constructor converts JSON Map into Post object.
  ///
  /// JSON from API is:
  ///
  /// Map<String,dynamic>
  ///
  /// Example:
  ///
  /// {
  ///   "id":1,
  ///   "title":"abc"
  /// }
  ///
  /// factory allows creating an object from external data.
  factory Post.fromJson(
      Map<String, dynamic> json,
      ) {

    return Post(

      userId: json['userId'],

      id: json['id'],

      title: json['title'],

      body: json['body'],

    );
  }
}