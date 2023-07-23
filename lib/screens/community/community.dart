import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gro_better/model/user_info.dart';
import 'package:gro_better/provider/user_provider.dart';
import 'package:gro_better/screens/community/widgets/post_status.dart';
import 'package:gro_better/screens/community/widgets/post_view.dart';
import 'package:gro_better/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:gro_better/screens/experts/experts.dart';

import '../../shared/constants.dart';

class CommunityScreen extends StatelessWidget {
  CommunityScreen({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    UserDetails? userInfo = Provider.of<UserProvider>(context).getUser;
    Size size = MediaQuery.of(context).size;

    // UserDetails document = UserDetails.fromMap(snapshot.data);
    return Scaffold(
      //  backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // alignment: Alignment.center,
            decoration: const BoxDecoration(gradient: gradientColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 8),
                    kWidth10,
                  ],
                ),

                Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(150),
                        ),
                        color: Color.fromARGB(255, 66, 34, 5)),
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
                        Text(
                          'Hello, ${userInfo?.name ?? ''}!',
                          style: textStyle2,
                        ),
                        kHeight20,
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
