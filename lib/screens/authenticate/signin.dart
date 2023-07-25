import 'package:flutter/material.dart';
import 'package:gro_better/screens/authenticate/widgets/forget_password.dart';
import 'package:gro_better/screens/authenticate/widgets/login_page_logo.dart';
import 'package:gro_better/screens/authenticate/widgets/text_form_field.dart';
import 'package:gro_better/services/auth.dart';
import 'package:gro_better/shared/constants.dart';
import 'package:gro_better/shared/loading.dart';

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
        : LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Scaffold(
                //  backgroundColor: Colors.brown[100],
                appBar: AppBar(
                    backgroundColor: kPrimaryColor,
                    elevation: 0.0,
                    centerTitle: true,
                    title: Text(
                      'Gro Better',
                      style: appBarTitleText,
                    )
                    //   style: Theme.of(context)
                    //       .textTheme
                    //       .headlineMedium!
                    //       .copyWith(color: kTextColor2, fontWeight: FontWeight.bold),
                    // ),
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
                            const LoginPageLogo(),

                            kHeight10,

                            // welcome back, you've been missed!
                            const Text('Welcome! Sign In to get better',
                                style: textStyle2),

                            kHeight20,
                            Container(
                              margin: const EdgeInsets.all(20),
                              child: Form(
                                  key: _formKey,
                                  child: Center(
                                    child: Column(
                                      children: <Widget>[
                                        // username textfield
                                        TextFormFieldWidget(
                                          hintText: 'Email or Username',
                                          validator: (val) {
                                            val!.isEmpty
                                                ? 'Enter an email'
                                                : null;
                                            return null;
                                          },
                                          onChanged: (val) {
                                            setState(() {
                                              email = val;
                                            });
                                          },
                                        ),
                                        // TextFormField(
                                        //   decoration: textInputDecoration.copyWith(
                                        //       hintText: 'Email or Username'),
                                        //   validator: (val) => val!.isEmpty
                                        //       ? 'Enter an email'
                                        //       : null,
                                        //   onChanged: (val) {
                                        //     setState(() {
                                        //       email = val;
                                        //     });
                                        //   },
                                        // ),

                                        kHeight10,

                                        // password textfield
                                        TextFormFieldWidget(
                                          hintText: 'Password',
                                          validator: (val) => val!.length < 6
                                              ? 'Password must be at least 6 characters long'
                                              : null,
                                          onChanged: (val) {
                                            setState(() {
                                              password = val;
                                            });
                                          },
                                          obscureText: true,
                                        ),

                                        // TextFormField(
                                        //   decoration: textInputDecoration.copyWith(
                                        //       hintText: 'Password'),
                                        //   validator: (value) => value!.length < 6
                                        //       ? 'Password must be at least 6 characters long'
                                        //       : null,
                                        //   obscureText: true,
                                        //   onChanged: (value) {
                                        //     setState(() {
                                        //       password = value;
                                        //     });
                                        //   },
                                        // ),

                                        const SizedBox(height: 10),

                                        // forgot password?
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ForgetPassword(),
                                                  ));
                                                },
                                                child: const Text(
                                                  'Forgot Password?',
                                                  style: textStyle2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        kHeight10,
                                        //  const SizedBox(height: 20),

                                        // sign in button
                                        SizedBox(
                                          width: 120,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      kPrimaryColor),
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
                                              child: const Text('Sign In')),
                                        ),

                                        Text(
                                          error,
                                          style: const TextStyle(
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
                              label: const Text('Sign in with Google Account'),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                children: [
                                  const Text(
                                    "Don't have an account yet? ",
                                    style: textStyle2,
                                  ),
                                  TextButton.icon(
                                      onPressed: () {
                                        widget.toggleView();
                                      },
                                      icon: const Icon(Icons.app_registration),
                                      label: const Text('Register here')),
                                ],
                              ),
                            ),

                            //  kHeight20,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }
}
