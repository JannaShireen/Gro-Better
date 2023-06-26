import 'package:flutter/material.dart';

// SignInProvider class
class SignInProvider extends ChangeNotifier {
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  void setError(String error) {
    this.error = error;
    notifyListeners();
  }

  void setLoading(bool loading) {
    this.loading = loading;
    notifyListeners();
  }
}
