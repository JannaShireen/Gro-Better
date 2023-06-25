import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gro_better/model/post.dart';

class PostViewWidget extends StatelessWidget {
  const PostViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<Post> posts = snapshot.data!.docs
                  .map((doc) => Post.fromDocumentSnapshot(doc))
                  .toList();

              return Container(
                padding: const EdgeInsets.all(10.0), // Add desired spacing
                child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (BuildContext context, int index) {
                      final post = posts[index];
                      return Card(
                        color: Colors.white60,
                        elevation: 10,
                        margin: const EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 23),
                                child: Container(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: const Icon(
                                      Icons.person,
                                      size: 50,
                                    )),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(post.username,
                                        style: GoogleFonts.roboto(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 12.0),
                                    Text(post.content),
                                    const SizedBox(height: 16.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: Icon(post.isLiked
                                                  ? Icons.favorite
                                                  : Icons.favorite_border),
                                              onPressed: () {
                                                // setState(() {
                                                //   post.isLiked = !post.isLiked;
                                                //   if (post.isLiked) {
                                                //     post.likeCount++;
                                                //   } else {
                                                //     post.likeCount--;
                                                //   }
                                                // });
                                              },
                                            ),
                                            Text(post.likeCount.toString()),
                                          ],
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.comment),
                                          onPressed: () {
                                            // Handle comment button press
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(post.isSaved
                                              ? Icons.bookmark
                                              : Icons.bookmark_border),
                                          onPressed: () {
                                            // setState(() {
                                            //   post.isSaved = !post.isSaved;
                                            // });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}


    
                  // child: ListTile(
                  //   title: Row(
                  //     children: [
                  //       const CircleAvatar(
                  //         child: Icon(Icons.person),
                  //       ),
                  //       const SizedBox(width: 10),
                  //       Consumer<PostOptionsProvider>(
                  //         builder: (context, provider, child) {
                  //           return Text(
                  //             provider.isAnonymous
                  //                 ? 'Anonymous'
                  //                 : post.username,
                  //             style: textStyle2,
                  //           );
                  //         },
                  //       ),
                  //     ],
                  //   ),
                  //   //Text(post.username),
                  //   subtitle: Text(post.content),
                  //   // Display other post information as needed
                  // ),
    