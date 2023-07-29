import 'package:flutter/material.dart';
import 'package:gro_better/shared/constants.dart';

class LoginAgain extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  LoginAgain({super.key});

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter an email address.';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  String? _validatePassword(String? value){
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, perform your submission logic here
      
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(children: [
        const Text('We are sorry to see you go.'),
        TextFormField(
          controller: emailController,
        ),
        TextFormField(
          controller: passwordController,
        ),
        ElevatedButton(onPressed: () {}, child: const Text('Continue'))
      ]),
    );
  }
}
