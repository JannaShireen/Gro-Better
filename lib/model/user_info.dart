import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails {
  final String uid;
  final String name;
  final String email;
  final DateTime dob;
  final String? bioNotes;
  final String? nationality;
  final String imageUrl;
  final int? sessionCount;
  List<String> sessionNotes = [];
  List<String> posts = [];
  List<String> comments = [];

  // Add more properties as needed

  UserDetails(
      {required this.uid,
      required this.name,
      required this.email,
      required this.dob,
      this.bioNotes,
      this.nationality,
      this.sessionCount,
      this.imageUrl = "",
      this.sessionNotes = const [],
      this.posts = const [],
      this.comments = const []});

  Map<String, dynamic> toJson() => {
        "UserID": uid,
        "Name": name,
        "Username": email,
        "DateOfBirth": dob,
        "BioNotes": bioNotes,
        "Nationality": nationality,
        "SessionCount": sessionCount,
        "SessionNotes": sessionNotes,
        "Posts": posts,
        "Comments": comments,
        "imageUrl": imageUrl,
      };

  static UserDetails fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserDetails(
        uid: snapshot['UserID'],
        name: snapshot['Name'],
        email: snapshot['Username'],
        dob: (snapshot['DateOfBirth'] as Timestamp).toDate(),
        bioNotes: snapshot['BioNotes'],
        nationality: snapshot['nationality'],
        sessionCount: snapshot['sessionCount'],
        sessionNotes: List<String>.from(snapshot['SessionNotes'] ?? []),
        posts: List<String>.from(snapshot['Posts'] ?? []),
        comments: List<String>.from(snapshot['Comments'] ?? []),
        imageUrl: snapshot['ImageUrl'] ?? "");
  }
}
