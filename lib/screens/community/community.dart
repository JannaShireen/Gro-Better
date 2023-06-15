import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gro_better/screens/community/widgets/post_status.dart';
import 'package:gro_better/screens/community/widgets/post_view.dart';
import 'package:gro_better/services/auth.dart';
import 'package:gro_better/shared/widgets/profile_pic.dart';

import '../../shared/constants.dart';

class CommunityScreen extends StatelessWidget {
  CommunityScreen({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Container(
          // alignment: Alignment.center,
          decoration: const BoxDecoration(gradient: gradientColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/logo.png", width: 45, height: 45),
                  const SizedBox(width: 8),
                  Text(
                    'Gro Better',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: kBackgroundColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                  ),
                ],
              ),
              Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(150),
                      ),
                      color: Color.fromARGB(248, 64, 123, 96)),
                  height: 200,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                          onPressed: () {},
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
                  )),
              //

              const SizedBox(
                height: 30,
              ),
              DividerTeal,
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 241, 238, 238),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ProfilePic(imageUrl: 'janna.jpeg'),
                      ),
                      const SizedBox(
                          width:
                              15), // Add some spacing between the CircleAvatar and TextFormField
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CreatePostWidget()),
                          );
                          const CreatePostWidget();
                        },
                        child: Container(
                          //  margin: EdgeInsets.only(left: 8),
                          height: 60,
                          // width: MediaQuery.of(context).size.width * 0.74,
                          decoration: BoxDecoration(
                            color: Colors.tealAccent,
                            backgroundBlendMode: BlendMode.overlay,
                            borderRadius: BorderRadius.circular(
                                50.0), // Adjust the border radius as desired
                          ),
                          child: const Center(
                            child: Text(
                              "What's on your mind?",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              const Expanded(child: PostViewWidget()),
              //
            ],
          ),
        ),
      ),
    );
  }
}
