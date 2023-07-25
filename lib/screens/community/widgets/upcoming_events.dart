import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gro_better/services/database/booking_db.dart';
import 'package:gro_better/shared/constants.dart';
import 'package:gro_better/shared/loading.dart';
import 'package:intl/intl.dart';

class UpcomingEvents extends StatelessWidget {
  const UpcomingEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 231, 231),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          'Upcoming Events',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot?>(
        stream: FetchBookings(uId: currentuserId).fetchUpcomingBooking(),
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
                  'No upcoming events found.',
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
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.26,
                    width: MediaQuery.of(context).size.width * 0.2,
                    margin: const EdgeInsets.all(17),
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        border: Border(
                            left: BorderSide(color: Colors.green, width: 5))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          ' Appointment date',
                          style: TextStyle(color: Colors.grey),
                        ),
                        kHeight10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Icon(Icons.lock_clock),
                            Text(
                              '   $monthName  ${dateTime.day.toString()} -  ${event['time']}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Icon(
                              Icons.video_call,
                              color: Colors.green,
                              size: 33,
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        Card(
                          elevation: 3,
                          child: ListTile(
                            leading: CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    NetworkImage(event['expert_dp'])),
                            title: Text(
                              'Dr. ${event['expert_name']}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(event['category']),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
