import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gro_better/model/post.dart';
import 'package:gro_better/screens/community/widgets/post_card.dart';
import 'package:gro_better/screens/community/widgets/post_status.dart';
import 'package:gro_better/shared/constants.dart';
import 'package:gro_better/shared/loading.dart';

class ThoughtsTab extends StatelessWidget {
  const ThoughtsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .where('authorId', isEqualTo: currentuserId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for data to load, show a loading indicator or placeholder
          return Loading();
        } else if (snapshot.hasError) {
          // If there's an error, show an error message
          return Text('Error: ${snapshot.error}');
        } else {
          // If data is available, check if there are any posts
          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            // If there are no posts, display the message and button
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "You haven't posted anything yet.",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                kHeight10,
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => CreatePostWidget()),
                    );
                  },
                  child: const Text(
                    'Share your thoughts',
                    style: TextStyle(color: kBackgroundColor),
                  ),
                ),
              ],
            );
          } else {
            // If there are posts, display them here
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                // Extract the post data from the DocumentSnapshot
                DocumentSnapshot<Map<String, dynamic>> postSnapshot = snapshot
                    .data!
                    .docs[index] as DocumentSnapshot<Map<String, dynamic>>;

                Post post = Post.fromDocumentSnapshot(
                    postSnapshot); // Use the fromDocumentSnapshot method to create a Post object

                // Display the post using your desired widget
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PostCard(post: post),
                );
                // return ListTile(
                //   title: Text(post.content),
                //   subtitle: Text(post.username),
                //   // Customize the ListTile as needed
                // );
              },
            );
          }
        }
      },
    );
  }
}
