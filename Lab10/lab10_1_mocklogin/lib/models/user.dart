/// User model represents authenticated user.
///
/// In a real application, this data usually comes
/// from backend API after successful login.
///
/// Example response:
///
/// {
///   "id":1,
///   "email":"admin@gmail.com",
///   "token":"abc123"
/// }
class User {
  final int id;

  final String email;

  final String token;

  const User({required this.id, required this.email, required this.token});
}
