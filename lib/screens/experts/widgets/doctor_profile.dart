import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gro_better/screens/experts/widgets/doctor_short_bio.dart';
import 'package:gro_better/shared/constants.dart';
import 'package:gro_better/shared/widgets/profile_pic.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DoctorProfile extends StatelessWidget {
  const DoctorProfile({super.key});

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
        'profilePictureUrl': 'assets/images/ryan_reynolds.jpg',
        'feedback': 'Excellent experience. Highly recommended!',
      },
    ];
    return Scaffold(
        appBar: AppBar(
          title: const Text('Know Your Expert'),
          automaticallyImplyLeading: true,
          backgroundColor: kBackgroundColor,
        ),
        body: Stack(children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(gradient: gradientColor),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Row(
                        children: const [
                          ProfilePic(imageUrl: 'ryan_reynolds.webp'),
                          kWidth10,
                          DrBioNotes(),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 30, top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: kDefaultIconLightColor,
                            ),
                            padding: const EdgeInsets.all(10),
                            child: const Text('702 Sessions'),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: kDefaultIconLightColor,
                            ),
                            padding: const EdgeInsets.all(10),
                            child: const Text('7 yrs experience'),
                          )
                        ],
                      ),
                    ),
                    DividerTeal,
                    kHeight10,
                    Text('What can I help you achieve:',
                        style: headingTextStyle),
                    kHeight20,
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemBuilder: (context, index) {
                        // Define different content for each card based on the index
                        IconData iconData;
                        String text;
                        switch (index) {
                          case 0:
                            iconData = Icons.alarm;
                            text = 'Time Management';
                            break;
                          case 1:
                            iconData = CupertinoIcons.briefcase_fill;
                            text = 'Career Guidance';
                            break;
                          case 2:
                            iconData = CupertinoIcons.heart_fill;
                            text = 'Relationship ';
                            break;
                          default:
                            iconData = Icons.error;
                            text = 'Unknown';
                        }

                        return Card(
                          elevation: 3,
                          color: kBackgroundColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                iconData,
                                size: 40,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                text,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    kHeight10,
                    Text(
                      'About',
                      style: headingTextStyle,
                    ),
                    kHeight10,
                    const Text(
                      "Hey, I am Ryan, a passionate Mental Health Professional specializing in Counseling Psychology. Being an adolescent can be tough and it comes with its own unique changes and obstacles. I think they deserve a helping hand which is why I love walking through the life journey with them and helping them maximize their potential. ",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    kHeight20,
                    Text(
                      'What can you ask me:',
                      style: headingTextStyle,
                    ),
                    kHeight10,
                    const Text(
                      '♦️ How do I manage my time and schedule?',
                      style: TextStyle(color: Colors.white),
                    ),
                    kHeight10,
                    const Text('♦️ How do I plan for my career?',
                        style: TextStyle(color: Colors.white)),
                    kHeight10,
                    const Text('♦️ How do I become more efficient?',
                        style: TextStyle(color: Colors.white)),
                    kHeight10,
                    const Text('♦️ How do I become more self-aware? ',
                        style: TextStyle(color: Colors.white)),
                    kHeight20,
                    Text(
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
                            Text(
                              'Rating',
                              style: headingTextStyle,
                            ),
                            kHeight10,
                            Padding(
                              padding: const EdgeInsets.only(left: 95),
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
                                              color: Colors.white),
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
                    //user feedback
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage: AssetImage(
                                        feedback['profilePictureUrl']),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          feedback['username'],
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          feedback['feedback'],
                                          style: const TextStyle(fontSize: 16),
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
                  backgroundColor: MaterialStateProperty.all(kButtonColor)),
              onPressed: () {
                // Action when the button is pressed
              },
              child: const Text(
                'Connect',
                style: TextStyle(
                    fontSize: 17,
                    color: kBackgroundColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ]));
  }
}
