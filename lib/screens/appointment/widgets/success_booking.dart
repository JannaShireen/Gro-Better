import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gro_better/screens/community/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:gro_better/shared/constants.dart';
import 'package:lottie/lottie.dart';

class SuccessBooking extends StatelessWidget {
  final String date;
  final String time;
  final String image;
  final String name;
  final String category;
  final String paymentId;
  const SuccessBooking({
    Key? key,
    required this.image,
    required this.name,
    required this.category,
    required this.date,
    required this.time,
    required this.paymentId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 350),
              child: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const HomeScreen();
                  }));
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            kHeight10,
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(image),
                radius: 70,
              ),
            ),
            kHeight10,
            Text(
              name,
              style: GoogleFonts.outfit(),
            ),
            Text(
              category,
              style: GoogleFonts.outfit(),
            ),
            kHeight10,
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                height: 130,
                width: double.infinity,
                child: Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Timing : $time',
                        style: GoogleFonts.outfit(fontSize: 15),
                      ),
                      kHeight10,
                      Text(
                        'Appointment Date: $date  ',
                        style: GoogleFonts.outfit(fontSize: 15),
                      ),
                      kHeight10,
                      Text(
                        'Payment Id:  $paymentId',
                        style: GoogleFonts.outfit(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            kHeight20,
            Text(
              'Payment Successfully Completed!',
              style:
                  GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            kHeight10,
            Lottie.network(
                'https://assets3.lottiefiles.com/packages/lf20_xwmj0hsk.json',
                height: 200)
          ],
        ),
      ),
    );
  }
}
