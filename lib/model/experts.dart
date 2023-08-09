import 'package:cloud_firestore/cloud_firestore.dart';

class ExpertInfo {
  final String id;
  final String name;
  final String email;
  final String qualification;
  final String category;
  final double? fee;
  final String question1;
  final String question2;
  final String question3;
  final String imageUrl;
  String about;
  int sessionCount;
  DateTime fromTime;
  DateTime toTime;

  ExpertInfo({
    required this.id,
    required this.name,
    required this.email,
    required this.qualification,
    required this.category,
    this.fee,
    required this.fromTime,
    required this.toTime,
    this.question1 = '',
    this.question2 = '',
    this.question3 = '',
    this.imageUrl = '',
    this.about = '',
    this.sessionCount = 0,
  });
  Map<String, dynamic> toJson() {
    return {
      "ExpertID": id,
      "Name": name,
      "Email": email,
      "Qualification": qualification,
      "Category": category,
      "Question-1": question1,
      "Question-2": question2,
      "Question-3": question3,
      "SessionCount": sessionCount,
      "imageUrl": imageUrl,
      "fee": fee,
      "about": about,
      "fromTime": fromTime,
      "toTime": toTime,
    };
  }

  static ExpertInfo fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return ExpertInfo(
      id: snapshot['ExpertID'],
      name: snapshot['Name'],
      email: snapshot['Email'],
      qualification: snapshot['Qualification'],
      category: snapshot['Category'],
      sessionCount: snapshot['SessionCount'],
      question1: snapshot['Question-1'],
      question2: snapshot['Question-2'],
      question3: snapshot['Question-3'],
      imageUrl: snapshot['imageUrl'],
      fee: snapshot['fee']?.toDouble(),
      about: snapshot['about'],
      fromTime: (snapshot['fromTime'] as Timestamp).toDate(),
      toTime: (snapshot['toTime'] as Timestamp).toDate(),
    );
  }
}
