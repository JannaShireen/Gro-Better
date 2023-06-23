import 'package:flutter/material.dart';
import 'package:gro_better/services/database/database.dart';
import 'package:gro_better/shared/constants.dart';

class CreatePostWidget extends StatelessWidget {
  CreatePostWidget({super.key});

  final TextEditingController _textEditingController = TextEditingController();

  // void submitPost() {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            TextField(
              maxLines: 10,
              controller: _textEditingController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: 'What\'s on your mind?',
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  try {
                    submitPost();
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
                    backgroundColor: const Color.fromARGB(255, 26, 62, 28)),
                icon: const Icon(Icons.post_add_rounded),
                label: const Text('Post'))
          ],
        ),
      ),
    );
  }

  void submitPost() {
    var postContent = _textEditingController.text;
    DatabaseService(uid: currentuserId).postStatus(postContent);
  }
}
