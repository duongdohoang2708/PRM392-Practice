import '../models/user.dart';

/// AuthService handles authentication logic.
///
/// In real applications:
///
/// Flutter App
///      ↓
/// Backend API
///      ↓
/// Database
///
/// But in this lab:
/// We simulate backend behavior locally.
///
/// This helps understand authentication flow
/// before connecting a real API.
class AuthService {
  /// Fake login function.
  ///
  /// Return:
  /// - User object if login success
  /// - null if login failed
  ///
  /// We use Future because real authentication
  /// always takes time due to network requests.
  Future<User?> login(String email, String password) async {
    // Simulate network delay.
    //
    // Real app:
    // await http.post(...)
    //
    // Here:
    await Future.delayed(const Duration(seconds: 2));

    // Fake account.
    //
    // Correct:
    //
    // email:
    // admin@gmail.com
    //
    // password:
    // 123456
    if (email == "admin@gmail.com" && password == "123456") {
      return const User(
        id: 1,

        email: "admin@gmail.com",

        token: "mock_token_123456",
      );
    }

    // Login failed.
    return null;
  }
}
