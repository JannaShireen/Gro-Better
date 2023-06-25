import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gro_better/model/post.dart';
import 'package:gro_better/model/user_info.dart';
import 'package:gro_better/provider/post_options_provider.dart';
import 'package:gro_better/provider/user_provider.dart';
import 'package:gro_better/services/database/database.dart';
import 'package:gro_better/shared/constants.dart';
import 'package:provider/provider.dart';

class CreatePostWidget extends StatelessWidget {
  CreatePostWidget({Key? key}) : super(key: key);

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserDetails userInfo = Provider.of<UserProvider>(context).getUser;
    final String currentUsername = userInfo.email;
    return ChangeNotifierProvider(
      create: (_) => PostOptionsProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Post'),
          automaticallyImplyLeading: true,
          backgroundColor: const Color.fromARGB(248, 64, 123, 96),
        ),
        body: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(),
                  const SizedBox(width: 10),
                  Consumer<PostOptionsProvider>(
                    builder: (context, provider, child) {
                      return Text(
                        provider.isAnonymous
                            ? 'Anonymous'
                            : '@$currentUsername',
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
                  hintText: 'What\'s on your mind?',
                ),
              ),
              const SizedBox(height: 14),
              ElevatedButton.icon(
                onPressed: () {
                  try {
                    submitPost(context, currentUsername);
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
                  backgroundColor: const Color.fromARGB(255, 26, 62, 28),
                ),
                icon: const Icon(Icons.post_add_rounded),
                label: const Text('Post'),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Post as Anonymous'),
                  const SizedBox(width: 8),
                  Consumer<PostOptionsProvider>(
                    builder: (context, provider, child) {
                      return Switch(
                        value: provider.isAnonymous,
                        onChanged: (newValue) {
                          provider.setAnonymous(newValue);
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void submitPost(BuildContext context, String userName) async {
    var postContent = _textEditingController.text;
    var provider = Provider.of<PostOptionsProvider>(context, listen: false);
    Post newPost = Post(
        username: userName,
        content: postContent,
        isAnonymous: provider.isAnonymous,
        timeStamp: Timestamp.now());
    String? statusID =
        await DatabaseService(uid: currentuserId).postStatus(newPost);
    if (statusID != null) {
      await DatabaseService(uid: currentuserId)
          .updateStatusReferenceInUser(currentuserId, statusID);
    }
  }
}
