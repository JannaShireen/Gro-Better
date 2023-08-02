import 'package:flutter/cupertino.dart';

import '../services/auth.dart';

class RegisterUserState extends ChangeNotifier {
  final AuthService _auth = AuthService();

  bool loading = false;
  String error = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  String name = '';

  DateTime date = DateTime.now();

  final formKey = GlobalKey<FormState>();

  Future<dynamic> registerUser() async {
    try {
      loading = true;
      notifyListeners();

      dynamic result = await _auth.registerWithEmailAndPassword(
        name,
        email,
        password,
        date,
      );

      loading = false;
      notifyListeners();

      return result;
    } catch (error) {
      loading = false;
      notifyListeners();
      return null;
    }
  }
}
