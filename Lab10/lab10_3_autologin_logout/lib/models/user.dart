/// User model represents logged-in user.
///
/// Token is the most important information
/// because it is stored locally to keep session.
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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] ?? 0,

      username: json["username"] ?? "",

      email: json["email"] ?? "",

      token: json["accessToken"] ?? "",
    );
  }
}
