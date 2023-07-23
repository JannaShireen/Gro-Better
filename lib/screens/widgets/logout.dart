import 'package:flutter/material.dart';
import 'package:gro_better/services/auth.dart';
import 'package:gro_better/shared/constants.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
    required this.auth,
  });

  final AuthService auth;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        textStyle: const TextStyle(color: Colors.green),
      ),
      onPressed: () async {
        _showLogoutConfirmationDialog(context);
      },
      icon: const Icon(
        Icons.power_settings_new,
        color: Colors.white,
      ),
      label: const Text(
        'Log Out',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    final AuthService auth = AuthService();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await auth.Logout();
                Navigator.of(context).pop(); // Close the dialog
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kButtonColor)),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
