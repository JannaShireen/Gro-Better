import 'package:flutter/material.dart';
import 'package:gro_better/services/auth.dart';
import 'package:gro_better/shared/constants.dart';
import 'package:gro_better/shared/loading.dart';

class RegisterUser extends StatefulWidget {
  final Function toggleView;
  const RegisterUser({required this.toggleView, super.key});
  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

enum Gender {
  Male,
  Female,
}

class _RegisterUserState extends State<RegisterUser> {
  final AuthService _auth = AuthService();
  bool loading = false;
  String error = '';
  String email = '';
  String password = '';
  String name = '';
  int? age;
  Gender gender = Gender.Male;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('Sign up on Gro Better'),
              backgroundColor: kPrimaryColor,
            ),
            body: Container(
              margin: EdgeInsets.all(20),
              child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text('Already a member? '),
                          TextButton(
                              onPressed: () {
                                widget.toggleView();
                              },
                              child: Text('Log In')),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Full Name'),
                          ),
                          kHeight20,
                          TextFormField(
                            decoration:
                                textInputDecoration.copyWith(hintText: 'Email'),
                            validator: (val) =>
                                val!.isEmpty ? 'Enter an email' : null,
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                          ),
                          kHeight20,
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Password'),
                            validator: (value) => value!.length < 6
                                ? 'Password must be at least 6 characters long'
                                : null,
                            obscureText: true,
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                          ),
                          kHeight20,
                          TextFormField(
                            decoration:
                                textInputDecoration.copyWith(hintText: 'Age'),
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your age';
                              }
                              // You can add more complex age validation logic here
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                age = int.parse(value);
                              });
                            },
                          ),
                          kHeight20,
                          Container(
                              margin: EdgeInsets.only(right: 360),
                              child: Text(
                                'Gender',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              )),
                          ListTile(
                            title: const Text('Male'),
                            leading: Radio<Gender>(
                              value: Gender.Male,
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value!;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('Female'),
                            leading: Radio<Gender>(
                              value: Gender.Female,
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value!;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: kPrimaryColor),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    dynamic result = await _auth
                                        .registerWithEmailAndPassword(
                                            email, password);
                                    if (result == null) {
                                      setState(() {
                                        error = 'Enter a valid email';
                                        loading = false;
                                      });
                                    }
                                  }
                                },
                                child: Text('Register')),
                          ),
                          kHeight20,
                          Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  )),
            ),
          );
  }
}
