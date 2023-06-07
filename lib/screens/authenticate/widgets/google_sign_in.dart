import 'package:flutter/material.dart';

class GoogleSignIn extends StatelessWidget {
  const GoogleSignIn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // _SignInWithGoogle(context);
      },
      icon: Image.asset(
        'assets/images/google.png',
        height: 24.0,
        width: 24.0,
      ),
      label: Text('Sign in with Google Account'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
