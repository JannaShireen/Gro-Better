import 'package:flutter/material.dart';
import 'package:gro_better/services/auth.dart';
import 'package:gro_better/shared/constants.dart';
import 'package:gro_better/shared/loading.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({required this.toggleView, super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email = '';
  String password = '';
  String error = '';

  bool loading = false;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? Loading()
        : Scaffold(
            //  backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                'Gro Better',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),

            body: SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),

                        // logo
                        Image.asset(
                          'assets/images/download.jpg',
                        ),
                        // const Icon(
                        //   Icons.view_comfortable,
                        //   size: 100,
                        // ),
                        kHeight30,

                        // welcome back, you've been missed!
                        Text(
                          'Welcome! Sign In to get better',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.grey[700],
                            fontSize: 16,
                          ),
                        ),

                        kHeight20,
                        Container(
                          margin: EdgeInsets.all(20),
                          child: Form(
                              key: _formKey,
                              child: Center(
                                child: Column(
                                  children: <Widget>[
                                    // username textfield
                                    TextFormField(
                                      decoration: textInputDecoration.copyWith(
                                          hintText: 'Email or Username'),
                                      validator: (val) => val!.isEmpty
                                          ? 'Enter an email'
                                          : null,
                                      onChanged: (val) {
                                        setState(() {
                                          email = val;
                                        });
                                      },
                                    ),

                                    const SizedBox(height: 10),

                                    // password textfield
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

                                    const SizedBox(height: 10),

                                    // forgot password?
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Forgot Password?',
                                            style: TextStyle(
                                                color: Colors.grey[600]),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 20),

                                    // sign in button
                                    SizedBox(
                                      width: 150,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: kPrimaryColor),
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              setState(() {
                                                loading = true;
                                              });
                                              dynamic result = await _auth
                                                  .signEmailAndPassword(
                                                      email, password);
                                              if (result == null) {
                                                setState(() {
                                                  error =
                                                      'Wrong Username or Password';
                                                  loading = false;
                                                });
                                              }
                                            }
                                          },
                                          child: Text('Sign In')),
                                    ),

                                    Text(
                                      error,
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 14),
                                    )
                                  ],
                                ),
                              )),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            AuthService().SignInWithGoogle();
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
                        ),
                        kHeight20,

                        // Don't have an account?
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 0.5,
                                  color: Colors.grey[400],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  "Don't have an account yet? ",
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 0.5,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                        ),

                        //  kHeight20,

                        TextButton(
                            onPressed: () {
                              widget.toggleView();
                            },
                            child: Text('Register here')),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
