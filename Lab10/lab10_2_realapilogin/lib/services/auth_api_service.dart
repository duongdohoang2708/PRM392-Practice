import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user.dart';

/// AuthApiService handles authentication
/// communication with backend API.
///
/// Responsibilities:
///
/// - Send login request
/// - Receive response
/// - Parse JSON
/// - Return User object
class AuthApiService {
  static const String loginUrl = "https://dummyjson.com/auth/login";

  Future<User> login({
    required String username,

    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(loginUrl),

        headers: {"Content-Type": "application/json"},

        body: jsonEncode({"username": username, "password": password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return User.fromJson(data);
      } else {
        throw Exception("Invalid username or password");
      }
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
