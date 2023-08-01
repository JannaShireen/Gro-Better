import 'package:flutter/material.dart';
import 'package:gro_better/shared/constants.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 0.0,
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Gro Better VERSION 1.0'),
              kHeight20,
              Text(' Developed by Janna Shireen'),
            ],
          ),
        ),
      ),
    );
  }
}
