import 'package:shared_preferences/shared_preferences.dart';

/// StorageService manages local session.
///
/// SharedPreferences stores simple data:
///
/// - token
/// - username
/// - email
///
/// Similar to browser localStorage.
class StorageService {
  static const String tokenKey = "token";

  static const String usernameKey = "username";

  static const String emailKey = "email";

  /// Save user session after login.
  Future<void> saveUserSession({
    required String token,

    required String username,

    required String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(tokenKey, token);

    await prefs.setString(usernameKey, username);

    await prefs.setString(emailKey, email);
  }

  /// Check whether user already logged in.
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString(tokenKey);

    return token != null;
  }

  /// Get saved user information.
  Future<Map<String, String?>> getUserSession() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      "token": prefs.getString(tokenKey),

      "username": prefs.getString(usernameKey),

      "email": prefs.getString(emailKey),
    };
  }

  /// Remove session during logout.
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();
  }
}
