import 'package:flutter/material.dart';
import 'package:gro_better/model/user.dart';
import 'package:gro_better/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gro_better/services/auth.dart';
import 'package:gro_better/shared/constants.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      initialData: null,
      value: AuthService().userlog,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gro Better',
        theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          primaryColor: kPrimaryColor,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Wrapper(),
      ),
    );
  }
}
