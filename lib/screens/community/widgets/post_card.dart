import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gro_better/model/post.dart';
import 'package:gro_better/provider/post_options_provider.dart';
import 'package:gro_better/services/database/post_services.dart';
import 'package:gro_better/shared/constants.dart';
import 'package:provider/provider.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    bool isLiked = false,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    String firstLetter = post.username.substring(0, 1);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (post.authorId == currentuserId)
                  Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                          onPressed: () {
                            _showDeleteConfirmationDialog(context, post.postId);
                          },
                          icon: const Icon(Icons.delete))),

                Consumer<PostOptionsProvider>(
                  builder: (context, provider, child) {
                    return Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          child: post.isAnonymous
                              ? const Text(
                                  '👀',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )
                              : Text(
                                  firstLetter,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 24),
                                ),
                        ),
                        kWidth10,
                        Text(
                          post.isAnonymous ? 'Anonymous User' : post.username,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ],
                    );
                  },
                ),
                // Text(post.username,
                //     style: GoogleFonts.roboto(
                //         fontSize: 22, fontWeight: FontWeight.bold)),
                kHeight10,
                Text(
                  post.content,
                  style: const TextStyle(color: Colors.black),
                ),
                kHeight10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: post.likes.contains(currentuserId)
                              ? const Icon(Icons.favorite)
                              : const Icon(Icons.favorite_border),
                          onPressed: () {
                            PostServices(uid: currentuserId).likePost(
                                post.postId, currentuserId, post.likes);
                          },
                        ),
                        //   icon: Icon(post.isLiked
                        //       ? Icons.favorite
                        //       : Icons.favorite_border),
                        //   onPressed: () {
                        //     // setState(() {
                        //     //   post.isLiked = !post.isLiked;
                        //     //   if (post.isLiked) {
                        //     //     post.likeCount++;
                        //     //   } else {
                        //     //     post.likeCount--;
                        //     //   }
                        //     // });
                        //   },
                        // ),
                        Text(post.likes != null
                            ? post.likes.length.toString()
                            : '0'),
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
                const Divider(),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String postId) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 221, 215, 215),
            title: const Text('Delete Post?'),
            content: const Text('Are you sure you want to delete this post?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    DocumentReference postRef = FirebaseFirestore.instance
                        .collection('posts')
                        .doc(postId);
                    await postRef.delete();
                    const SnackBar(
                        content: Text('Post deleted successfullly.'));

                    Navigator.of(context).pop(); // Close the dialog
                  } catch (e) {
                    debugPrint('Error deleting post $e');
                    const SnackBar(
                      content: Text('Error deleting post'),
                    );
                  }
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                child: const Text('Delete'),
              ),
            ],
          );
        });
  }
}
