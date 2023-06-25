import 'package:flutter/material.dart';
import 'package:gro_better/services/auth.dart';

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
        await auth.Logout();
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
}
