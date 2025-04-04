import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const _storage = FlutterSecureStorage();
  static const _tokenKey = 'auth_token';
  static const _nameKey = 'user_name';

  Future<void> saveAuthToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<void> saveUserName(String name) async {
    await _storage.write(key: _nameKey, value: name);
  }

  Future<String?> getAuthToken() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<String?> getUserName() async {
    return await _storage.read(key: _nameKey);
  }

  Future<void> clearAuthData() async {
    await _storage.deleteAll();
  }
}
