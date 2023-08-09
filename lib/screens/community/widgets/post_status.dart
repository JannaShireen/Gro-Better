import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gro_better/model/post.dart';
import 'package:gro_better/model/user_info.dart';
import 'package:gro_better/provider/post_options_provider.dart';
import 'package:gro_better/provider/user_provider.dart';
import 'package:gro_better/services/database/post_services.dart';
import 'package:gro_better/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CreatePostWidget extends StatelessWidget {
  CreatePostWidget({Key? key}) : super(key: key);

  final TextEditingController _textEditingController = TextEditingController();
  bool isAnonymous = false;
  var uuid = const Uuid();
  @override
  Widget build(BuildContext context) {
    UserDetails? userInfo = Provider.of<UserProvider>(context).getUser;

    final String currentUsername = userInfo!.email.split('@')[0];
    String firstLetter = currentUsername.substring(0, 1);
    return ChangeNotifierProvider(
      create: (_) => PostOptionsProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Post'),
          automaticallyImplyLeading: true,
          backgroundColor: kPrimaryColor,
        ),
        body: Container(
          padding: const EdgeInsets.all(30.0),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Text(
                      firstLetter,
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Consumer<PostOptionsProvider>(
                    builder: (context, provider, child) {
                      return Text(
                        provider.isAnonymous
                            ? 'Anonymous'
                            : '@$currentUsername',
                        style: textStyle2,
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                maxLines: 10,
                controller: _textEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 113, 111, 111)),
                  hintText: 'What\'s on your mind?',
                ),
              ),
              kHeight20,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Post as Anonymous',
                    style: textStyle2,
                  ),
                  const SizedBox(width: 8),
                  Consumer<PostOptionsProvider>(
                    builder: (context, provider, child) {
                      return Switch(
                        value: provider.isAnonymous,
                        onChanged: (newValue) {
                          provider.setAnonymous(newValue);
                          isAnonymous = provider.isAnonymous;
                          print(
                              'isAnonymous value set to ${provider.isAnonymous}');
                        },
                      );
                    },
                  ),
                ],
              ),
              kHeight10,
              const Center(
                child: Text(
                  'Note: Your doctor can view your anonymous posts.',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              kHeight10,
              SizedBox(
                width: 70,
                child: ElevatedButton.icon(
                  onPressed: () {
                    try {
                      submitPost(context, currentUsername, isAnonymous);
                      // Show a SnackBar with the success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Status updated successfully'),
                        ),
                      );
                      Navigator.of(context).pop();
                    } catch (e) {
                      print('Error posting status: $e');
                      // Show a SnackBar with the error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Error updating status'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                  ),
                  icon: const Icon(Icons.post_add_rounded),
                  label: const Text('Post'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void submitPost(
      BuildContext context, String userName, bool isAnonymousIn) async {
    String newPostId = uuid.v1();
    DateTime currentTime = DateTime.now();
    Timestamp timestamp = Timestamp.fromDate(currentTime);

    var postContent = _textEditingController.text;

    // print(
    //     'Value of isAnonymous inside submitPost before creating Post object $isAnonymousIn');
    Post newPost = Post(
      postId: newPostId,
      authorId: currentuserId,
      username: userName,
      content: postContent,
      isAnonymous: isAnonymousIn,
      timeStamp: timestamp,
      likes: [],
    );
    await PostServices(uid: currentuserId).postStatus(newPost);
  }
}
