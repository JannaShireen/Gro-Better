import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gro_better/screens/widgets/prescription.dart';
import 'package:gro_better/services/database/booking_db.dart';
import 'package:gro_better/shared/constants.dart';
import 'package:gro_better/shared/loading.dart';
import 'package:intl/intl.dart';

class MyRecords extends StatelessWidget {
  const MyRecords({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot?>(
      stream: FetchBookings(uId: currentuserId).fetchPastBookings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          final upcomingEventsSnapshot = snapshot.data;
          if (upcomingEventsSnapshot == null ||
              upcomingEventsSnapshot.size == 0) {
            return const Center(
              child: Text(
                'No past records found.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: upcomingEventsSnapshot.size,
              itemBuilder: (context, index) {
                var event = upcomingEventsSnapshot.docs[index];
                DateTime dateTime = event['date'].toDate();
                String monthName = DateFormat('MMMM').format(dateTime);
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const PrescriptionScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        kHeight20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '   $monthName  ${dateTime.day.toString()} -  ${event['time']}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        ListTile(
                          leading: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage(event['expert_dp'])),
                          title: Text(
                            'Dr. ${event['expert_name']}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(event['category']),
                          trailing: const Icon(
                            Icons.message,
                            color: Colors.green,
                          ),
                        ),
                        const Divider()
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }
      },
    );
  }
}
