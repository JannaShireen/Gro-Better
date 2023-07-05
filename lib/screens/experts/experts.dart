import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:gro_better/model/experts.dart';
import 'package:gro_better/screens/experts/widgets/doctor_profile.dart';
import 'package:gro_better/shared/constants.dart';

class DoctorsList extends StatelessWidget {
  const DoctorsList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Experts').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<ExpertInfo> experts = snapshot.data!.docs
                .map((doc) => ExpertInfo.fromSnap(doc))
                .toList();
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: experts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, childAspectRatio: 1),
                itemBuilder: (context, index) {
                  final expert = experts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoctorProfile(
                                  expert: expert,
                                )),
                      );
                    },
                    child: Card(
                      color: kBackgroundColor,
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  child: Image.network(
                                    expert.imageUrl,
                                    fit: BoxFit.cover,
                                  )),
                              Text(
                                expert.name,
                                style: headingTextStyle,
                              ),
                              Text(
                                expert.category,
                                style: GoogleFonts.lato(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ]),
                      ),
                    ),
                  );
                },
              ),
            );

            // return Container(
            //   padding: const EdgeInsets.all(10.0), // Add desired spacing

            //   child: ListView.builder(
            //       shrinkWrap: true,
            //       physics: const NeverScrollableScrollPhysics(),
            //       itemCount: experts.length,
            //       itemBuilder: (BuildContext context, int index) {
            //         final expert = experts[index];
            //         return ListTile(
            //           leading: const CircleAvatar(backgroundColor: Colors.blue),
            //           title: Text(expert.name),
            //           subtitle: Text(expert.category),
            //         );
            //       }),
            // );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
