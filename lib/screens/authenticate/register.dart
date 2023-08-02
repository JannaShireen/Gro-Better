import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gro_better/screens/authenticate/widgets/text_form_field.dart';
import 'package:gro_better/shared/constants.dart';
import 'package:gro_better/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../provider/form.dart';

class RegisterUser extends StatelessWidget {
  final Function toggleView;

  const RegisterUser({required this.toggleView, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterUserState>(
      builder: (context, state, _) {
        return state.loading
            ? Loading()
            : Scaffold(
                appBar: AppBar(
                  title: TextButton(
                    onPressed: () {
                      toggleView();
                    },
                    child: const Text(
                      'Already a member? ',
                      style: kTextStyle,
                    ),
                  ),
                  //title: const Text('Sign up on Gro Better'),
                  backgroundColor: kPrimaryColor,
                ),
                body: Container(
                  margin: const EdgeInsets.all(20),
                  child: Form(
                    key: state.formKey,
                    child: SingleChildScrollView(
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            const Text(
                              'Sign up on Gro Better',
                              style: headingTextStyle,
                            ),
                            kHeight30,
                            TextFormFieldWidget(
                              hintText: 'Full name',
                              onChanged: (value) {
                                state.name = value;
                              },
                            ),
                            kHeight20,
                            TextFormFieldWidget(
                              hintText: 'Email',
                              validator: (val) =>
                                  val!.isEmpty ? 'Enter an email' : null,
                              onChanged: (val) {
                                state.email = val;
                              },
                            ),
                            kHeight20,
                            TextFormFieldWidget(
                              hintText: 'Password',
                              validator: (value) => value!.length < 6
                                  ? 'Password must be at least 6 characters long'
                                  : null,
                              obscureText: true,
                              onChanged: (value) {
                                state.password = value;
                              },
                            ),
                            kHeight20,
                            TextFormFieldWidget(
                              hintText: 'Confirm Password',
                              validator: (value) => value != state.password
                                  ? 'Password do not match'
                                  : null,
                              obscureText: true,
                              onChanged: (value) {
                                state.confirmPassword = value;
                              },
                            ),
                            kHeight20,
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    kWidth10,
                                    const Text('Date of Birth',
                                        style: textStyle2),
                                    kWidth10,
                                    kWidth10,
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green[200],
                                      ),
                                      onPressed: () async {
                                        await showCupertinoModalPopup<void>(
                                          context: context,
                                          builder: (_) {
                                            final size =
                                                MediaQuery.of(context).size;
                                            return Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(12),
                                                  topRight: Radius.circular(12),
                                                ),
                                              ),
                                              height: size.height * 0.27,
                                              child: CupertinoDatePicker(
                                                mode: CupertinoDatePickerMode
                                                    .date,
                                                initialDateTime: DateTime.now(),
                                                onDateTimeChanged: (value) {
                                                  state.date = value;
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: const Text(
                                        'Choose Date',
                                        style: TextStyle(color: kPrimaryColor),
                                      ),
                                    ),
                                  ],
                                ),
                                kHeight20,

                                //
                              ],
                            ),
                            kHeight20,
                            SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kPrimaryColor,
                                ),
                                onPressed: () async {
                                  if (state.formKey.currentState!.validate()) {
                                    state.loading = true;
                                    dynamic result = await state.registerUser();
                                    if (result == null) {
                                      state.error = 'Enter another email id';
                                      state.loading = false;
                                    }
                                  }
                                },
                                child: const Text('Register'),
                              ),
                            ),
                            kHeight20,
                            Text(
                              state.error,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                              ),
                            ),
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

String parseDate(DateTime date) {
  final date0 = DateFormat('yyyy-MM-dd').format(date);
  return date0;
}
