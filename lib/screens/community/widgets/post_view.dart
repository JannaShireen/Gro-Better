import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:gro_better/model/post.dart';
import 'package:gro_better/screens/community/widgets/post_card.dart';

class PostViewWidget extends StatelessWidget {
  const PostViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Post> posts = snapshot.data!.docs
                .map((doc) => Post.fromDocumentSnapshot(doc))
                .toList();

            return Container(
              padding: const EdgeInsets.all(10.0), // Add desired spacing
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PostCard(
                      post: posts[index],
                    );
                  }),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
