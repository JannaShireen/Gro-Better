import 'package:flutter/material.dart';
import 'package:gro_better/model/post.dart';
import 'package:gro_better/provider/post_options_provider.dart';
import 'package:provider/provider.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
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
                  Consumer<PostOptionsProvider>(
                    builder: (context, provider, child) {
                      return Text(
                        provider.isAnonymous ? 'Anonymous' : post.username,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      );
                    },
                  ),
                  // Text(post.username,
                  //     style: GoogleFonts.roboto(
                  //         fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12.0),
                  Text(post.content),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
  }
}
