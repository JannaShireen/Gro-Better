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
          // crossAxisAlignment:
          //     CrossAxisAlignment.start, // Aligns children to the left
          children: [
            // Text(
            //   'Gro Better',
            //   style: Theme.of(context).textTheme.titleLarge!.copyWith(
            //         color: Colors.black,
            //         fontWeight: FontWeight.bold,
            //       ),
            // ),
            const SizedBox(
                height:
                    12), // Add some space between the text and FutureBuilder
            FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future:
                  FetchBookings(uId: currentuserId).fetchFirstUpcomingBooking(),
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
                      ));
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



// GestureDetector(
//   onTap: () {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => CreatePostWidget()),
//     );
//     //  CreatePostWidget();
//   },
//   child: const Padding(
//     padding: EdgeInsets.all(10.0),
//     child: Text(
//       "What's on your mind?",
//       style: TextStyle(color: Colors.grey),
//     ),
//   ),
// ),
// const Icon(Icons.edit_document)

// Widget noScheduledAppointmentsWidget() {
//   return Text(
//     'You have no scheduled appointment.',
//     style: GoogleFonts.robotoCondensed(
//       textStyle: const TextStyle(
//         fontWeight: FontWeight.bold,
//         fontSize: 12,
//         color: Colors.white,
//       ),
//     ),
//   );
// }

// Widget appointmentDetailsWidget(
//     DocumentSnapshot<Map<String, dynamic>> snapshot, BuildContext context) {
//   String time = snapshot['time'];
//   String day = snapshot['day'];
//   DateTime dateTime = snapshot['date'].toDate();
//   String month = DateFormat('MMM').format(dateTime);

//   return TextButton(
//     onPressed: () {
//       Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//         return const UpcomingEvents();
//       }));
//     },
//     child: Text(
//       'You have an appointment at $time \non $day, $month ${dateTime.day}. ',
//       style: const TextStyle(color: kDefaultIconLightColor, fontSize: 16),
//     ),
//   );
// }

// class CommunityScreen extends StatelessWidget {
//   CommunityScreen({super.key});

//   final AuthService _auth = AuthService();

//   QuerySnapshot? upcomingEvent;

//   @override
//   @override
//   Widget build(BuildContext context) {
//     UserDetails? userInfo = Provider.of<UserProvider>(context).getUser;
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Container(
//             // alignment: Alignment.center,
//             decoration: const BoxDecoration(gradient: gradientColor),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       kWidth10,
//                       Text(
//                         'Hello, ${userInfo?.name ?? ''}!',
//                         style: const TextStyle(
//                             color: Colors.black, fontWeight: FontWeight.bold),
//                       ),
//                       IconButton(
//                           onPressed: () {
//                             Navigator.of(context)
//                                 .push(MaterialPageRoute(builder: (context) {
//                               return const UpcomingEvents();
//                             }));
//                           },
//                           icon: const Icon(Icons.calendar_month)),
//                     ],
//                   ),
//                 ),

//                 Container(
//                     decoration: const BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(40),
//                           bottomRight: Radius.circular(150),
//                         ),
//                         color: kPrimaryColor),
//                     height: 200,
//                     width: double.infinity,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Gro Better',
//                           style: Theme.of(context)
//                               .textTheme
//                               .headlineMedium!
//                               .copyWith(
//                                 color: kTextColor2,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 31,
//                               ),
//                         ),
//                         kHeight20,

//                         FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//                             future: FetchBookings(uId: currentuserId)
//                                 .fetchFirstUpcomingBooking(),
//                             builder: (context, snapshot) {
//                               if (snapshot.connectionState ==
//                                   ConnectionState.waiting) {
//                                 return Loading();
//                               } else if (snapshot.hasError) {
//                                 return Scaffold(
//                                   body: Center(
//                                     child: Text('Error: ${snapshot.error}'),
//                                   ),
//                                 );
//                               } else {
//                                 DocumentSnapshot<Map<String, dynamic>>?
//                                     upcomingEventSnapshot = snapshot.data;
//                                 bool hasUpcomingEvent =
//                                     upcomingEventSnapshot != null;
//                                 // print('upcoming event $upcomingEventSnapshot');
//                                 return Container(
//                                   decoration: const BoxDecoration(
//                                     borderRadius: BorderRadius.only(
//                                       bottomLeft: Radius.circular(40),
//                                       bottomRight: Radius.circular(150),
//                                     ),
//                                     color: kPrimaryColor,
//                                   ),
//                                   height: 200,
//                                   width: double.infinity,
//                                   child: SingleChildScrollView(
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       children: [
//                                         hasUpcomingEvent
//                                             ? appointmentDetailsWidget(
//                                                 upcomingEventSnapshot, context)
//                                             : noScheduledAppointmentsWidget(),
//                                       ],
//                                     ),
//                                   ),
//                                 );

//                                 // if (upcomingEventSnapshot == null) {
//                                 //   return SizedBox(
//                                 //     height: 100,
//                                 //     child: Center(
//                                 //       child: Text(
//                                 //         'You have no scheduled appointment.',
//                                 //         style: GoogleFonts.robotoCondensed(
//                                 //             textStyle: const TextStyle(
//                                 //                 fontWeight: FontWeight.bold,
//                                 //                 fontSize: 12,
//                                 //                 color: Colors.white)),
//                                 //       ),
//                                 //     ),
//                                 //   );
//                                 // } else {
//                                 //   String time = upcomingEventSnapshot['time'];
//                                 //   String day = upcomingEventSnapshot['day'];
//                                 //   DateTime dateTime =
//                                 //       upcomingEventSnapshot['date'].toDate();
//                                 //   String month =
//                                 //       DateFormat('MMM').format(dateTime);

//                                 //   return TextButton(
//                                 //       onPressed: () {
//                                 //         Navigator.of(context).push(
//                                 //             MaterialPageRoute(
//                                 //                 builder: (context) {
//                                 //           return const UpcomingEvents();
//                                 //         }));
//                                 //       },
//                                 //       child: Text(
//                                 //         'You have an appointment at $time \non $day, $month ${dateTime.day}. ',
//                                 //         style: const TextStyle(
//                                 //             color: kDefaultIconLightColor,
//                                 //             fontSize: 16),
//                                 //       ));
//                                 // }
//                               }
//                             }),

//                         //
//                       ],
//                     )),
//                 Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Container(
//                     height: 40,
//                     width: MediaQuery.of(context).size.width / 1.2,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: const Color.fromARGB(255, 215, 187, 161),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         // const ProfilePic(imageUrl: 'add-user-dp.png'),
//                         // Add some spacing between the CircleAvatar and TextFormField
//                         
//                 ),
//                 //

//                 const PostViewWidget(),
//                 //
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//  

// 
