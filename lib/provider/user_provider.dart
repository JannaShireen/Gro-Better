import 'package:flutter/material.dart';
import 'package:gro_better/model/user_info.dart';
import 'package:gro_better/services/database/database.dart';
import 'package:gro_better/shared/constants.dart';

class UserProvider with ChangeNotifier {
  late UserDetails _user =
      UserDetails(uid: ' ', name: 'jan', email: ' ', dob: DateTime.now());

  final DatabaseService db = DatabaseService(uid: currentuserId);

  UserDetails get getUser => _user;

  Future<void> refreshUser() async {
    UserDetails user = await db.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
