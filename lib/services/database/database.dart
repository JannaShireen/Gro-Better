import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gro_better/model/post.dart';
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

  final CollectionReference _postsCollection =
      FirebaseFirestore.instance.collection('posts');

  Future updateUserData(UserDetails userDetails) async {
    return await userCollection.doc(uid).set(userDetails.toJson());
  }

  Future editUserData(String bioNotes, String nationality) async {
    await userCollection.doc(uid).update({
      'BioNotes': bioNotes,
      'Nationality': nationality,
    });
  }

  Future<UserDetails> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firebaseFirestore.collection('users').doc(currentUser.uid).get();
    return UserDetails.fromSnap(snap);
  }

// Post a status to the firebase and return a statusID
  Future<String?> postStatus(Post newPost) async {
    try {
      // Create a new document with a unique ID in the "statuses" collection
      DocumentReference statusRef = _postsCollection.doc();

      // Get the unique ID generated for the document
      String statusId = statusRef.id;

      // Set the fields for the status document
      await statusRef.set(newPost.toJson());

      // Return the unique ID
      return statusId;
    } catch (error) {
      print('Error posting status: $error');
      // Return null if an error occurs
      return null;
    }
  }

  // Update the statusID in the respective user collection
  Future<void> updateStatusReferenceInUser(
      String userId, String statusId) async {
    try {
      // Get the reference to the user document in the "users" collection
      DocumentReference userRef = userCollection.doc(userId);

      // Get the user document data
      DocumentSnapshot userSnapshot = await userRef.get();
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;

      // Create a new map for the updated "statusReferences" field
      Map<String, dynamic> updatedData = {
        'statusReferences':
            FieldValue.arrayUnion([_postsCollection.doc(statusId)]),
      };

      // If the user has a "postedBy" field, add the statusId to it
      // if (userData.containsKey('postedBy')) {
      //   updatedData['postedBy'] = FieldValue.arrayUnion([statusId]);
      // } else {
      //   updatedData['postedBy'] = [statusId];
      // }

      // Update the user document with the new data
      await userRef.update(updatedData);
    } catch (error) {
      print('Error updating status reference in user: $error');
    }
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
