import 'package:flutter/material.dart';

class LoginPageLogo extends StatelessWidget {
  const LoginPageLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 180,
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(20), // Adjust the border radius as needed
        child: Image.asset(
          'assets/images/session.webp', // Replace with your image path
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
