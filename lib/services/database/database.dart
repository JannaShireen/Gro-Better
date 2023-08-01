import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gro_better/model/user_info.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // Create instances of FirebaseAuth and FirebaseFirestore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //collection reference

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference postsCollection =
      FirebaseFirestore.instance.collection('posts');

  Future updateUserData(UserDetails userDetails) async {
    return await userCollection.doc(uid).set(userDetails.toJson());
  }

  Future editUserData(String bioNotes, String nationality) async {
    await userCollection.doc(uid).update({
      'BioNotes': bioNotes,
    });
  }

  Future deleteUserRecords() async {
    try {
      await userCollection.doc(uid).delete();
      // Query to get all posts with the provided authorId
      QuerySnapshot querySnapshot =
          await postsCollection.where('authorId', isEqualTo: uid).get();
      // Loop through the documents and delete them one by one
      querySnapshot.docs.forEach((doc) async {
        await doc.reference.delete();
      });
    } catch (e) {
      print('Error deleting user records $e');
    }
  }

  Future<UserDetails> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firebaseFirestore.collection('users').doc(currentUser.uid).get();
    return UserDetails.fromSnap(snap);
  }

  //
  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }

  // Stream<DocumentSnapshot> getUserStream(String uid) {
  //   return FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
  // }
  Future<String> updateImageToStorage(String uid, File imageFile) async {
    try {
      String filename = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
          FirebaseStorage.instance.ref().child('images/$uid/$filename');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      // Handle the error appropriately
      rethrow;
    }
  }
}
