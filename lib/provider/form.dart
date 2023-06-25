import 'package:flutter/cupertino.dart';

import '../services/auth.dart';

enum Gender {
  Male,
  Female,
}

extension GenderExtension on Gender {
  String get value {
    switch (this) {
      case Gender.Male:
        return 'Male';
      case Gender.Female:
        return 'Female';
      default:
        return '';
    }
  }
}

class RegisterUserState extends ChangeNotifier {
  final AuthService _auth = AuthService();

  final Gender _gender = Gender.Male;

  Gender get gender => _gender;

  bool loading = false;
  String error = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  String name = '';

  DateTime date = DateTime.now();
  // Gender gender = Gender.Male;
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
