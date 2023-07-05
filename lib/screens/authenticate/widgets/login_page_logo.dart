import 'package:flutter/material.dart';

class LoginPageLogo extends StatelessWidget {
  const LoginPageLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.64,
      height: MediaQuery.of(context).size.height * 0.26,
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
