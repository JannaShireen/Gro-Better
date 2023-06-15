import 'package:flutter/material.dart';

class CreatePostWidget extends StatefulWidget {
  const CreatePostWidget({super.key});

  @override
  _CreatePostWidgetState createState() => _CreatePostWidgetState();
}

class _CreatePostWidgetState extends State<CreatePostWidget> {
  final TextEditingController _textEditingController = TextEditingController();

  void _submitPost() {
    // Perform the action when the post button is pressed
    String postContent = _textEditingController.text;
    // Process the post content, save to database, etc.
    // Clear the input field
    _textEditingController.clear();
  }

  @override
  void dispose() {
    // Dispose the text editing controller when the widget is disposed
    _textEditingController.dispose();
    super.dispose();
  }

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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 26, 62, 28)),
                icon: const Icon(Icons.post_add_rounded),
                label: const Text('Post'))
          ],
        ),
      ),
    );
  }
}
