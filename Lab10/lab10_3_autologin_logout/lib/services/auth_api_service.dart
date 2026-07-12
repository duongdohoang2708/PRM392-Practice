import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user.dart';

/// Handles login API.
///
/// This service only communicates with backend.
class AuthApiService {
  final String url = "https://dummyjson.com/auth/login";

  Future<User> login({
    required String username,

    required String password,
  }) async {
    final response = await http.post(
      Uri.parse(url),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode({"username": username, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return User.fromJson(data);
    } else {
      throw Exception("Invalid username or password");
    }
  }
}
