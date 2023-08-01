import 'package:flutter/material.dart';
import 'package:gro_better/model/experts.dart';
import 'package:gro_better/screens/appointment/book_appointment.dart';
import 'package:gro_better/shared/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class DoctorProfile extends StatelessWidget {
  ExpertInfo expert;
  DoctorProfile({required this.expert, super.key});

  @override
  Widget build(BuildContext context) {
    List<double> userRatings = [4.5, 3.0, 5.0];
    List<Map<String, dynamic>> userFeedback = [
      {
        'username': 'John Doe',
        'profilePictureUrl': 'assets/images/miley.jpg',
        'feedback': 'Great service!',
      },
      {
        'username': 'Jane Smith',
        'profilePictureUrl': 'assets/images/Jane_Smith.jpg',
        'feedback': 'Very helpful and knowledgeable.',
      },
      {
        'username': 'Alex Johnson',
        'profilePictureUrl': 'assets/images/Jane_Smith.jpg',
        'feedback': 'Excellent experience. Highly recommended!',
      },
    ];
    return Scaffold(
        appBar: AppBar(
          title: const Text('Know Your Expert'),
          automaticallyImplyLeading: true,
          backgroundColor: kPrimaryColor,
        ),
        body: Stack(children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Column(children: [
                //Doctor's Image
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: MediaQuery.of(context).size.height / 2.9,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(expert.imageUrl),
                            fit: BoxFit.cover),
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                      ),
                    ),

                    // child: Image.network(
                    //   expert.imageUrl,
                    //   fit: BoxFit.cover,
                    // )

                    kHeight20,

                    //Doctor's name and other info

                    Text(
                      (expert.name.toUpperCase()),
                      style: headingTextStyle,
                    ),
                    kHeight10,
                    Text(
                      expert.category,
                      style: textStyle2,
                    ),
                    kHeight10,
                    expert.fee != null
                        ? Text(
                            'Fee : ${expert.fee} INR / Hour',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 17),
                          )
                        : const Text(
                            'Fee not added yet',
                            style: textStyle2,
                          ),
                    kHeight10,
                    Text(
                      ' ${expert.sessionCount}  Sessions',
                      style: const TextStyle(color: Colors.black, fontSize: 17),
                    ),
                    kHeight20,
                    const Text(
                      'Tentative Availability (in IST)',
                      style: headingTextStyle,
                    ),
                    kHeight10,
                    Text(
                      'Mon - Sat    ${DateFormat.Hm().format(expert.fromTime)} - ${DateFormat.Hm().format(expert.toTime)}',
                      // 'Mon - Sat     05.00 PM - 09.00 PM',
                      style: textStyle2,
                    ),

                    kHeight10,
                  ],
                ),
                kHeight10,
                DividerTeal,
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    //About
                    const Text(
                      'About',
                      style: headingTextStyle,
                    ),
                    kHeight10,
                    expert.about != null
                        ? Text(
                            expert.about,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 17),
                          )
                        : const Text('Not added'),

                    //What can you ask me?
                    kHeight20,
                    const Text(
                      'What can you ask me:',
                      style: headingTextStyle,
                    ),
                    kHeight20,
                    Text(
                      '♦️ ${expert.question1}',
                      style: const TextStyle(color: Colors.black, fontSize: 17),
                    ),
                    kHeight10,
                    Text('♦️ ${expert.question2}',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 17)),
                    kHeight10,
                    Text('♦️ ${expert.question3}',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 17)),
                    kHeight20,
                    // User Reviews
                    const Text(
                      'User Reviews',
                      style: headingTextStyle,
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white30,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Rating',
                              style: headingTextStyle,
                            ),
                            kHeight10,
                            Padding(
                              padding: const EdgeInsets.only(left: 55),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: userRatings.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 8),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(4.0),
                                          child: RatingBarIndicator(
                                            rating: userRatings[index],
                                            itemBuilder: (context, index) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            itemCount: 5,
                                            itemSize: 20.0,
                                            direction: Axis.horizontal,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '${userRatings[index]}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ]),
                    ),
                    kHeight10,
                  ],
                ),

                //       kWidth10,
                //       Column(
                //         children: [
                //           Text(
                //             expert.name,
                //             style: headingTextStyle,
                //           ),
                //           kHeight10,
                //           Text(
                //             expert.category,
                //             style: GoogleFonts.lato(
                //                 fontWeight: FontWeight.bold,
                //                 color: Colors.white),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding:
                //       const EdgeInsets.only(left: 30, top: 10, bottom: 10),
                //   child: Container(
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(8),
                //       color: kDefaultIconLightColor,
                //     ),
                //     padding: const EdgeInsets.all(10),
                //     child: Text('${expert.sessionCount} sessions'),
                //   ),
                // ),
                // DividerTeal,
                // kHeight10,
                // Text('What can I help you achieve:',
                //     style: headingTextStyle),
                // kHeight20,
                // GridView.builder(
                //   shrinkWrap: true,
                //   physics: const NeverScrollableScrollPhysics(),
                //   itemCount: 3,
                //   gridDelegate:
                //       const SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 3,
                //   ),
                //   itemBuilder: (context, index) {
                //     // Define different content for each card based on the index
                //     IconData iconData;
                //     String text;
                //     switch (index) {
                //       case 0:
                //         iconData = Icons.alarm;
                //         text = 'Time Management';
                //         break;
                //       case 1:
                //         iconData = CupertinoIcons.briefcase_fill;
                //         text = 'Career Guidance';
                //         break;
                //       case 2:
                //         iconData = CupertinoIcons.heart_fill;
                //         text = 'Relationship ';
                //         break;
                //       default:
                //         iconData = Icons.error;
                //         text = 'Unknown';
                //     }

                //     return Card(
                //       elevation: 3,
                //       color: kBackgroundColor,
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Icon(
                //             iconData,
                //             size: 40,
                //             color: Colors.white,
                //           ),
                //           const SizedBox(height: 10),
                //           Text(
                //             text,
                //             style: const TextStyle(
                //                 fontSize: 16, color: Colors.white),
                //           ),
                //         ],
                //       ),
                //     );
                //   },
                // ),

                // kHeight10,
                // Text(
                //   'About',
                //   style: headingTextStyle,
                // ),
                // kHeight10,
                // Text(
                //   "Hey, I am ${expert.name}, a passionate Mental Health Professional specializing in Counseling Psychology. Being an adolescent can be tough and it comes with its own unique changes and obstacles. I think they deserve a helping hand which is why I love walking through the life journey with them and helping them maximize their potential. ",
                //   style: const TextStyle(color: Colors.white, fontSize: 17),
                // ),
                // kHeight20,
                // Text(
                //   'What can you ask me:',
                //   style: headingTextStyle,
                // ),
                // kHeight10,
                // Text(
                //   '♦️ ${expert.question1}',
                //   style: const TextStyle(color: Colors.white, fontSize: 17),
                // ),
                // kHeight10,
                // Text('♦️ ${expert.question2}',
                //     style:
                //         const TextStyle(color: Colors.white, fontSize: 17)),
                // kHeight10,
                // Text('♦️ ${expert.question3}',
                //     style:
                //         const TextStyle(color: Colors.white, fontSize: 17)),
                // kHeight10,

                //user feedback
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'User Feedback',
                      style: headingTextStyle,
                    ),
                    kHeight10,
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: userFeedback.length,
                      itemBuilder: (context, index) {
                        final feedback = userFeedback[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    AssetImage(feedback['profilePictureUrl']),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      feedback['username'],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      feedback['feedback'],
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    ),
                                    const Divider(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ]),
            ),
          ),
          Positioned(
            bottom: 15,
            left: 200,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kPrimaryColor)),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BookAppointment(
                          expert: expert,
                        )));
                // Action when the button is pressed
              },
              child: const Text(
                'Book Appoinment',
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ]));
  }
}
