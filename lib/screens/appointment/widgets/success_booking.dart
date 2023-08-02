import 'package:flutter/material.dart';
import 'package:gro_better/screens/community/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:gro_better/shared/constants.dart';
import 'package:lottie/lottie.dart';

class SuccessBooking extends StatelessWidget {
  final String date;
  final String time;
  final String image;
  final String name;
  final String category;

  const SuccessBooking({
    Key? key,
    required this.image,
    required this.name,
    required this.category,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber[50],
        body: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const HomeScreen();
                  }));
                },
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.amber[50])),
                child: const Text(
                  'Done',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            kHeight30,
            const Text(
              'Payment Successfully Completed!',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            kHeight10,
            Lottie.network(
                'https://lottie.host/1c17976b-08b8-4c6b-bcf9-a8bda2d91207/HoF11yqmPP.json',
                height: 150),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.76,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(
                width: 2,
                color: Colors.black,
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(image),
                      radius: 50,
                    ),
                  ),
                  Text(
                    name.toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    category,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  kHeight10,
                  Text(
                    'Reservation Time : $time',
                    style: const TextStyle(fontSize: 15),
                  ),
                  kHeight10,
                  Text(
                    'Reservation Date: $date  ',
                    style: const TextStyle(fontSize: 15),
                  ),
                  kHeight10,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
