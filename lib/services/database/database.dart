import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gro_better/screens/authenticate/register.dart';
import 'package:gro_better/shared/constants.dart';

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

  void postStatus(status) async {
    try {
      // String userId = FirebaseAuth.instance.currentUser!.uid;

      // Create a new document with a unique ID in the "statuses" collection
      DocumentReference statusRef =
          FirebaseFirestore.instance.collection('statuses').doc();

      // Set the fields for the status document
      await statusRef.set({
        'userId': currentuserId,
        'status': status,
        'timestamp': FieldValue.serverTimestamp(),
      });
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text('Status updated successfully'),
      //   ),
      // );

      print('Status posted successfully!');
    } catch (error) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text('Error updating status'),
      //   ),
      // );
      print('Error posting status: $error');
    }
  }

  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }

  // Stream<DocumentSnapshot> getUserStream(String uid) {
  //   return FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
  // }
}
