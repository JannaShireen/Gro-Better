import 'package:flutter/material.dart';
import 'package:gro_better/screens/authenticate/widgets/text_form_field.dart';
import 'package:gro_better/services/auth.dart';
import 'package:gro_better/shared/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:restart_app/restart_app.dart';

class LoginAgain extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginAgain({Key? key}) : super(key: key);

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter an email address.';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, perform your submission logic here
      AuthService()
          .deleteAccount(emailController.text, passwordController.text);
    }
    Restart.restartApp();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 5, right: 15, left: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Lottie.network(
                  'https://lottie.host/3263438b-12ce-485c-bc1b-74c70d799814/HhlYUjsufC.json',
                  height: 80,
                  width: 80),
              const Text(
                'We are sorry to see you go.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
              ),
              const Text(
                'Please login again',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormFieldWidget(
                      hintText: 'Email',
                      controller: emailController,
                      validator: _validateEmail,
                    ),
                    kHeight10,
                    TextFormFieldWidget(
                      hintText: 'Password',
                      obscureText: true,
                      controller: passwordController,
                      validator: _validatePassword,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _submitForm,
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kPrimaryColor)),
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
