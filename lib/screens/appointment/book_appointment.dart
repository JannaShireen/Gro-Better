import 'package:flutter/material.dart';
import 'package:gro_better/model/experts.dart';
import 'package:gro_better/shared/constants.dart';

class BookAppointment extends StatelessWidget {
  ExpertInfo expert;
  BookAppointment({required this.expert, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: const Text('Book Appoinment'),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: gradientColor),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(expert.imageUrl),
              ),
              title: Text(expert.name),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width / 1.8,
              height: MediaQuery.of(context).size.height / 1.7,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
