import 'package:flutter/material.dart';

import 'package:gro_better/services/auth.dart';
import 'package:gro_better/shared/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
        title: Text(
          'My Profile',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: <Widget>[
          OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                  textStyle: TextStyle(color: Colors.green)),
              onPressed: () async {
                await _auth.Logout();
              },
              icon: Icon(
                Icons.power_settings_new,
                color: Colors.white,
              ),
              label: Text(
                'Log Out',
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
      body: SafeArea(
          child: Center(
        child: Text('My Profile'),
      )),
    );
  }
}
