import 'package:flutter/material.dart';
import 'package:gro_better/model/user_info.dart';
import 'package:gro_better/services/database/database.dart';
import 'package:gro_better/shared/constants.dart';

class UserProvider with ChangeNotifier {
  UserDetails? _user;
  final DatabaseService db = DatabaseService(uid: currentuserId);

  UserDetails get getUser => _user!;

  Future<void> refreshUser() async {
    UserDetails user = await db.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
