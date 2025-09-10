import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  Map<String, dynamic>? _userData;

  bool get isLoggedIn => _isLoggedIn;
  Map<String, dynamic>? get userData => _userData;

  // تسجيل مستخدم جديد
  void signup(Map<String, dynamic> userData) {
    _userData = userData;
    _isLoggedIn = true;
    notifyListeners();
  }

  // تسجيل دخول
  bool login(String email, String password) {
    if (_userData != null &&
        _userData!['email'] == email &&
        _userData!['password'] == password) {
      _isLoggedIn = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _isLoggedIn = false;
    _userData = null;
    notifyListeners();
  }
}
