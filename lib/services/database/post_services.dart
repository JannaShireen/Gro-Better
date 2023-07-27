import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gro_better/model/post.dart';

class PostServices {
  final String uid;
  PostServices({required this.uid});

  // Create instances of FirebaseAuth and FirebaseFirestore

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //collection reference

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference _postsCollection =
      FirebaseFirestore.instance.collection('posts');

// Post a status to the firebase and return a statusID
  Future postStatus(Post newPost) async {
    try {
      // Create a new document with a unique ID in the "statuses" collection
      DocumentReference statusRef = _postsCollection.doc(newPost.postId);

      // Get the unique ID generated for the document
      // String statusId = statusRef.id;

      // Set the fields for the status document
      await statusRef.set(newPost.toJson());

      // Return the unique ID
      // return statusId;
    } catch (error) {
      // print('Error posting status: $error');
      // Return null if an error occurs
      // return null;
    }
  }

  // Update the statusID in the respective user collection
  // Future<void> updateStatusReferenceInUser(
  //     String userId, String statusId) async {
  //   try {
  //     print("printing userID $userId");
  //     // Get the reference to the user document in the "users" collection
  //     DocumentReference userRef = userCollection.doc(userId);

  //     // Get the user document data
  //     DocumentSnapshot userSnapshot = await userRef.get();
  //     Map<String, dynamic> userData =
  //         userSnapshot.data() as Map<String, dynamic>;

  //     // Create a new map for the updated "statusReferences" field
  //     Map<String, dynamic> updatedData = {
  //       'statusReferences':
  //           FieldValue.arrayUnion([_postsCollection.doc(statusId)]),
  //     };

  //     // Update the user document with the new data
  //     await userRef.update(updatedData);
  //   } catch (error) {
  //     print('Error updating status reference in user: $error');
  //   }
  // }

  //like post

  Future<void> likePost(
    String postId,
    String uid,
    List likes,
  ) async {
    try {
      if (likes.contains(uid)) {
        await _firebaseFirestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firebaseFirestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
