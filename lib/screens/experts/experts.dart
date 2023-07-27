import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:gro_better/model/experts.dart';
import 'package:gro_better/screens/experts/widgets/doctor_profile.dart';
import 'package:gro_better/screens/experts/widgets/doctor_search.dart';
import 'package:gro_better/shared/constants.dart';

class DoctorsList extends StatelessWidget {
  const DoctorsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kBackgroundColor,
          title: const Text(
            'Experts',
            style: headingTextStyle,
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const DoctorSearchPage()));
            },
            icon: const Icon(Icons.search),
            color: Colors.black,
          ),
        ),
        body: const ListofDoctors());
  }
}

class ListofDoctors extends StatelessWidget {
  const ListofDoctors({
    super.key,
  });

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
              padding: const EdgeInsets.all(36.0),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: experts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, childAspectRatio: 1),
                itemBuilder: (context, index) {
                  final expert = experts[index];
                  return InkWell(
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
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                      elevation: 5,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                child: Image.network(
                                  expert.imageUrl,
                                  fit: BoxFit.cover,
                                )),
                            kHeight10,
                            Text(
                              expert.name,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 7, 0, 0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23),
                            ),
                            kHeight10,
                            Text(
                              expert.category,
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 18, 11, 11)),
                            ),
                          ]),
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
