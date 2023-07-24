import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gro_better/model/user_info.dart';
import 'package:gro_better/provider/user_provider.dart';
import 'package:gro_better/screens/community/widgets/post_status.dart';
import 'package:gro_better/screens/community/widgets/post_view.dart';
import 'package:gro_better/screens/community/widgets/upcoming_events.dart';
import 'package:gro_better/screens/experts/experts.dart';
import 'package:gro_better/services/auth.dart';
import 'package:gro_better/services/database/booking_db.dart';
import 'package:gro_better/shared/loading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../shared/constants.dart';

class CommunityScreen extends StatelessWidget {
  CommunityScreen({super.key});

  final AuthService _auth = AuthService();

  QuerySnapshot? upcomingEvent;

  @override
  @override
  Widget build(BuildContext context) {
    UserDetails? userInfo = Provider.of<UserProvider>(context).getUser;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // alignment: Alignment.center,
            decoration: const BoxDecoration(gradient: gradientColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    kWidth10,
                    Text(
                      'Hello, ${userInfo?.name ?? ''}!',
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const UpcomingEvents();
                          }));
                        },
                        icon: const Icon(Icons.calendar_month)),
                  ],
                ),

                Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(150),
                        ),
                        color: kPrimaryColor),
                    height: 200,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Gro Better',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: kTextColor2,
                                fontWeight: FontWeight.bold,
                                fontSize: 31,
                              ),
                        ),
                        kHeight20,

                        FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                            future: FetchBookings(uId: currentuserId)
                                .fetchFirstUpcomingBooking(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Loading();
                              } else if (snapshot.hasError) {
                                return Scaffold(
                                  body: Center(
                                    child: Text('Error: ${snapshot.error}'),
                                  ),
                                );
                              } else {
                                DocumentSnapshot<Map<String, dynamic>>?
                                    upcomingEventSnapshot = snapshot.data;

                                if (upcomingEventSnapshot == null) {
                                  return Column(
                                    children: [
                                      Text(
                                        'You have no scheduled appointment.',
                                        style: GoogleFonts.robotoCondensed(
                                            textStyle: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.white)),
                                      ),
                                      TextButton.icon(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const DoctorsList()));
                                          },
                                          icon: const Icon(
                                            Icons.calendar_month_outlined,
                                            color: kDefaultIconLightColor,
                                          ),
                                          label: Text('Schedule Now',
                                              style: GoogleFonts.lato(
                                                  color: kDefaultIconLightColor,
                                                  fontWeight: FontWeight.bold,
                                                  decoration: TextDecoration
                                                      .underline)))
                                    ],
                                  );
                                } else {
                                  String time = upcomingEventSnapshot['time'];
                                  String day = upcomingEventSnapshot['day'];
                                  DateTime dateTime =
                                      upcomingEventSnapshot['date'].toDate();
                                  String month =
                                      DateFormat('MMM').format(dateTime);

                                  return TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const UpcomingEvents();
                                        }));
                                      },
                                      child: Text(
                                        'You have an appointment at $time \non $day, $month ${dateTime.day}. ',
                                        style: const TextStyle(
                                            color: kDefaultIconLightColor,
                                            fontSize: 16),
                                      ));
                                }
                              }
                            }),

                        //
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 1.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 215, 187, 161),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // const ProfilePic(imageUrl: 'add-user-dp.png'),
                        // Add some spacing between the CircleAvatar and TextFormField
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
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        const Icon(Icons.edit_document)
                      ],
                    ),
                  ),
                ),
                //

                const PostViewWidget(),
                //
              ],
            ),
          ),
        ),
      ),
    );
  }
}
