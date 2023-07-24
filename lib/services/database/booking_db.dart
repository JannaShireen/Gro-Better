import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gro_better/shared/constants.dart';

class FetchBookings {
  final String uId;
  FetchBookings({required this.uId});

  // Create instances of FirebaseAuth and FirebaseFirestore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //collection reference

  final CollectionReference expertCollection =
      FirebaseFirestore.instance.collection('Experts');

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Stream<QuerySnapshot?> fetchUpcomingBooking() {
    CollectionReference ref =
        userCollection.doc(currentuserId).collection('myBookings');

    return ref
        .where('date', isGreaterThanOrEqualTo: DateTime.now())
        .snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>>
      fetchFirstUpcomingBooking() async {
    DocumentSnapshot<Map<String, dynamic>> upcomingEvent = await userCollection
        .doc(uId)
        .collection('myBookings')
        .where('date', isGreaterThanOrEqualTo: DateTime.now())
        .orderBy('date')
        .limit(1)
        .get()
        .then((querySnapshot) => querySnapshot.docs.first);

    return upcomingEvent;
  }
}
