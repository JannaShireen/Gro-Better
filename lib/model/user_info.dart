import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails {
  final String name;
  final String email;
  final String gender;
  final String dob;
  final String? bioNotes;

  // Add more properties as needed

  UserDetails(
      {required this.name,
      required this.email,
      required this.gender,
      required this.dob,
      this.bioNotes});
  factory UserDetails.fromDocument(DocumentSnapshot doc) {
    return UserDetails(
      name: doc['name'],
      email: doc['email'],
      gender: doc['username'],
      dob: doc['DOB'],
      bioNotes: doc['bioNotes'],
      // photoUrl: doc['photoUrl'],
    );
  }
}
