import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

var currentuserId = FirebaseAuth.instance.currentUser!.uid;
const kPrimaryColor = Color.fromARGB(255, 5, 118, 88);

const kTextColor = Color(0xFF3C4046);
const kTextColor2 = Colors.white;
const kButtonColor = Color.fromARGB(255, 143, 184, 184);
const kBackgroundColor = Color.fromARGB(255, 193, 225, 193);
const kBackgroundColor2 = Color.fromARGB(255, 254, 240, 226);
const kWidth10 = SizedBox(
  width: 10,
);
const TextStyle textStyle2 = TextStyle(
  fontWeight: FontWeight.w300,
  color: Colors.black,
  fontSize: 16,
);
const kHeight10 = SizedBox(height: 10);

const kHeight20 = SizedBox(height: 20);
const kHeight30 = SizedBox(height: 30);
const double kDefaultPadding = 20.0;
const gradientColor = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color.fromARGB(255, 205, 172, 142),
      Color.fromARGB(255, 177, 164, 150)
    ]);
TextStyle appBarTitleText = const TextStyle(
    color: kTextColor2, fontWeight: FontWeight.bold, fontSize: 42);
const TextStyle headingTextStyle =
    TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 21);
//GoogleFonts.lato(
//fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20);
const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(20.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kBackgroundColor, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
  ),
);
const DividerTeal = Divider(
  height: 10,
  color: Color.fromARGB(255, 66, 34, 5),
);

const nationalityText = Text(
  'Nationality:',
  style: textStyle2,
);
const bioText = Text(
  'Bio:',
  style: textStyle2,
);
const kTextStyle =
    TextStyle(fontSize: 17, color: kTextColor2, fontWeight: FontWeight.bold);
