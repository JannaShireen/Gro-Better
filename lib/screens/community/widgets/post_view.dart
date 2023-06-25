
// class PostViewWidget extends StatefulWidget {
//   const PostViewWidget({super.key});

//   @override
//   _PostViewWidgetState createState() => _PostViewWidgetState();
// }

// class _PostViewWidgetState extends State<PostViewWidget> {
//   List<Post> posts = [
//     Post(
//         username: 'User1',
//         content:
//             "For the great doesn't happen through impulse alone, and is a succession of little things that are brought together"),
//     Post(
//         username: 'User2',
//         content:
//             "To do the useful thing, to say the courageous thing, to contemplate the beautiful thing: that is enough for one man's life"),
//     Post(
//         username: 'User3',
//         content:
//             "The art of life is to know how to enjoy a little and to endure very much.")
//     // Add more posts here...
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: posts.length,
//       itemBuilder: (BuildContext context, int index) {
//         return buildPostCard(posts[index]);
//       },
//     );
//   }

//   Widget buildPostCard(Post post) {
//     return Card(
//       color: Colors.white60,
//       elevation: 10,
//       margin: const EdgeInsets.all(10),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(right: 23),
//               child: Container(
//                 alignment: AlignmentDirectional.centerStart,
//                 child: const ProfilePic(
//                   imageUrl: 'alan.jpg',
//                 ),
//               ),
//             ),
//             const SizedBox(
//               width: 3,
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(post.username,
//                       style: GoogleFonts.roboto(
//                           fontSize: 22, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 12.0),
//                   Text(post.content),
//                   const SizedBox(height: 16.0),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           IconButton(
//                             icon: Icon(post.isLiked
//                                 ? Icons.favorite
//                                 : Icons.favorite_border),
//                             onPressed: () {
//                               setState(() {
//                                 post.isLiked = !post.isLiked;
//                                 if (post.isLiked) {
//                                   post.likeCount++;
//                                 } else {
//                                   post.likeCount--;
//                                 }
//                               });
//                             },
//                           ),
//                           Text(post.likeCount.toString()),
//                         ],
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.comment),
//                         onPressed: () {
//                           // Handle comment button press
//                         },
//                       ),
//                       IconButton(
//                         icon: Icon(post.isSaved
//                             ? Icons.bookmark
//                             : Icons.bookmark_border),
//                         onPressed: () {
//                           setState(() {
//                             post.isSaved = !post.isSaved;
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
