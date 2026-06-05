class FakeAuthService {
  static String? _token;

  static Future<String?> getSavedToken() async {
    await Future.delayed(const Duration(seconds: 2));
    return _token;
  }

  static Future<String> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    final isValidAccount =
        email.trim().toLowerCase() == 'demo@test.com' &&
            password == '123456';

    if (!isValidAccount) {
      throw Exception('Email hoặc mật khẩu không đúng');
    }

    _token = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';
    return _token!;
  }

  static Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _token = null;
  }
}