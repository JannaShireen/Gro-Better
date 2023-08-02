import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gro_better/model/user_info.dart';
import 'package:gro_better/provider/user_provider.dart';
import 'package:gro_better/screens/community/widgets/post_status.dart';
import 'package:gro_better/screens/community/widgets/post_view.dart';
import 'package:gro_better/screens/community/widgets/upcoming_events.dart';
import 'package:gro_better/screens/experts/experts.dart';
import 'package:gro_better/services/database/booking_db.dart';
import 'package:gro_better/shared/constants.dart';
import 'package:gro_better/shared/loading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserDetails? userInfo = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: kBackgroundColor,
        title: Text(
          'Hello, ${userInfo?.name ?? ''}!',
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const UpcomingEvents();
              }));
            },
            icon: const Icon(Icons.calendar_month_sharp, color: Colors.black),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            const SizedBox(
                height:
                    12), // Add some space between the text and FutureBuilder
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FetchBookings(uId: currentuserId)
                  .streamFirstUpcomingBooking(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Loading();
                } else if (snapshot.hasError) {
                  return Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: kPrimaryColor),
                    padding: const EdgeInsets.all(15),
                    height: MediaQuery.of(context).size.height * 0.14,
                    child: Column(
                      children: [
                        Text(
                          'You have no scheduled appointment.',
                          style: GoogleFonts.robotoCondensed(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        TextButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const DoctorsList()));
                            },
                            icon: const Icon(
                              Icons.calendar_month_outlined,
                              color: kDefaultIconLightColor,
                            ),
                            label: Text('Schedule Now',
                                style: GoogleFonts.lato(
                                    color: kDefaultIconLightColor,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline)))
                      ],
                    ),
                  );
                } else {
                  DocumentSnapshot<Map<String, dynamic>>?
                      upcomingEventSnapshot = snapshot.data;
                  String time = upcomingEventSnapshot!['time'];
                  String day = upcomingEventSnapshot['day'];
                  DateTime dateTime = upcomingEventSnapshot['date'].toDate();
                  String month = DateFormat('MMM').format(dateTime);
                  //  print('upcoming events $upcomingEventSnapshot');
                  return Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: kPrimaryColor),
                    height: MediaQuery.of(context).size.height * 0.12,
                    child: Center(
                      child: Text(
                        'You have an appointment at $time \non $day, $month ${dateTime.day}. ',
                        style: kTextStyle,
                      ),
                    ),
                  );
                }
              },
            ),
            kHeight10,

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 1.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: kBackgroundColor2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreatePostWidget()),
                        );
                        //  CreatePostWidget();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "What's on your mind?",
                          style: TextStyle(
                              color: Color.fromARGB(255, 108, 107, 107)),
                        ),
                      ),
                    ),
                    const Icon(Icons.edit_document)
                  ],
                ),
              ),
            ),
            kHeight20,
            const PostViewWidget(),
            //
          ],
        ),
      ),
    );
  }
}
