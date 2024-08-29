import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Tokens {
  static String accessTokenKey = "ACCESS_TOKEN_KEY";
  static String refreshTokenKey = "REFRESH_TOKEN_KEY";
}

class TokenManager {
  static final TokenManager _instance = TokenManager._internal();

  factory TokenManager() => _instance;

  TokenManager._internal();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<String?> getToken() {
    return _storage.read(key: Tokens.accessTokenKey);
  }

  Future<void> setAccessToken(String? token) {
    return _storage.write(key: Tokens.accessTokenKey, value: token);
  }

  Future<void> deleteAccessToken() {
    return _storage.delete(key: Tokens.accessTokenKey);
  }

  // Refresh token methods
  Future<String?> getRefreshToken() {
    return _storage.read(key: Tokens.refreshTokenKey);
  }

  Future<void> setRefreshToken(String? token) {
    return _storage.write(key: Tokens.refreshTokenKey, value: token);
  }

  Future<void> deleteRefreshToken() {
    return _storage.delete(key: Tokens.refreshTokenKey);
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
