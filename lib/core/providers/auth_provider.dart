import 'package:flutter/material.dart';
import 'package:shoptreo/core/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  String? _token;
  String? _userName;
  bool _isLoading = true;

  bool get isAuthenticated => _token != null;

  String? get userName => _userName;

  bool get isLoading => _isLoading;

  Future<void> tryAutoLogin() async {
    _token = await _authService.getAuthToken();
    _userName = await _authService.getUserName();
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2)); // simulate API
    if (email == 'test@test.com' && password == 'Password123!') {
      _token = 'mock_token';
      _userName = 'Test User';
      await _authService.saveAuthToken(_token!);
      await _authService.saveUserName(_userName!);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> signup(String email, String password, String name) async {
    await Future.delayed(const Duration(seconds: 2)); // simulate API
    _token = 'mock_token';
    _userName = name;
    await _authService.saveAuthToken(_token!);
    await _authService.saveUserName(_userName!);
    notifyListeners();
  }

  Future<void> logout() async {
    _token = null;
    _userName = null;
    await _authService.clearAuthData();
    notifyListeners();
  }
}
