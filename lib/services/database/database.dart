import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gro_better/screens/authenticate/register.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  //collection reference

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(
      String name, String gender, DateTime dob, String email) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'gender': gender,
      'DOB': parseDate(dob),
      'Email': email,
    });
  }
}
