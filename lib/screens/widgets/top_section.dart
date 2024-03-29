import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gro_better/model/user_info.dart';
import 'package:gro_better/screens/profile/edit_profile.dart';
import 'package:gro_better/shared/constants.dart';
import 'package:gro_better/shared/loading.dart';

class TopSection extends StatelessWidget {
  const TopSection({super.key});

  @override
  Widget build(BuildContext context) {
    // UserDetails? userInfo = Provider.of<UserProvider>(context).getUser;
    // String firstLetter = userInfo!.name.substring(0, 1);
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(currentuserId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error fetching user details ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          var userInfo = UserDetails.fromSnap(snapshot.data!);
          String firstLetter = userInfo.name.substring(0, 1);
          return Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.black,
                      child: Text(
                        firstLetter,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 34),
                      ),
                    ),
                    kHeight10,
                    Text(
                      ' ${userInfo.name}',
                      style: const TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    kHeight10,
                    Text(
                      'DOB:  ${'${userInfo.dob}'.split(" ")[0]}',
                      style: textStyle2,
                    ),
                    kHeight10,
                    Text(
                      'Sessions: ${userInfo.sessionCount}',
                      style: textStyle2,
                    ),
                  ],
                ),
                Column(
                  children: [
                    kHeight30,
                    Text(
                      ' ${userInfo.bioNotes ?? ''}',
                      style: textStyle2,
                    ),
                    kHeight20,
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(kPrimaryColor)),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const EditProfile())));
                      },
                      child: const Text('Edit Bio'),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
