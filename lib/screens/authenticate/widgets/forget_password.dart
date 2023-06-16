import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gro_better/screens/authenticate/widgets/text_form_field.dart';
import 'package:gro_better/shared/constants.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  String email = '';

  final formkey = GlobalKey<FormState>();
  String error = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Reset Password'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  kHeight10,
                  TextFormFieldWidget(
                    hintText: 'Email or Username',
                    validator: (val) {
                      val!.isEmpty ? 'Enter an email' : null;
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        resetPassword(context);
                      },
                      child: const Text('Reset')),
                  Text(error),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void resetPassword(BuildContext context) async {
    if (formkey.currentState?.validate() ?? false) {
      try {
        await _auth.sendPasswordResetEmail(email: email.trim());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password reset email sent.'),
            duration: Duration(seconds: 3),
          ),
        );
        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to send reset email. Please try again.'),
            duration: Duration(seconds: 3),
          ),
        );
        print(e.toString());
      }
    }
  }
}
