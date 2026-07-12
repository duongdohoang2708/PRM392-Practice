/// User model represents authenticated user information.
///
/// This object is created from API response.
///
/// Example response:
///
/// {
///   "id":1,
///   "username":"emilys",
///   "email":"emily@example.com",
///   "accessToken":"abcxyz"
/// }
class User {
  final int id;

  final String username;

  final String email;

  final String token;

  const User({
    required this.id,

    required this.username,

    required this.email,

    required this.token,
  });

  /// Convert JSON response into User object.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,

      username: json['username'] ?? '',

      email: json['email'] ?? '',

      token: json['accessToken'] ?? '',
    );
  }
}
