import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gro_better/model/user.dart';
import 'package:gro_better/provider/doctor_search_provider.dart';
import 'package:gro_better/provider/form.dart';
import 'package:gro_better/provider/home_state.dart';
import 'package:gro_better/provider/post_options_provider.dart';
import 'package:gro_better/provider/user_provider.dart';
import 'package:gro_better/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gro_better/services/auth.dart';
import 'package:gro_better/shared/constants.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Assign publishable key to flutter_stripe
  Stripe.publishableKey =
      "pk_test_51NaV4CSJRQW4YVQ5bFrX1hedapCkJxvc4YZgTNSvBubW5lnRfJUSrHxzrDC53u3W9UKWtGhpo9j9EmuQ5OZlMmsl00TuaJux8Z";
  //Load our .env file that contains our Stripe Secret key
  await dotenv.load(fileName: "assets/.env");
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<UserModel?>.value(
            value: AuthService().userlog, initialData: null),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider<RegisterUserState>(
            create: (context) => RegisterUserState()),
        ChangeNotifierProvider<HomeState>(create: (context) => HomeState()),
        ChangeNotifierProvider(create: (context) => PostOptionsProvider()),
        ChangeNotifierProvider(create: (context) => DoctorSearchProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gro Better',
        theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          primaryColor: kPrimaryColor,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: kTextColor,
                fontFamily: GoogleFonts.robotoCondensed().fontFamily,
              ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const Wrapper(),
      ),
    );
  }
}
