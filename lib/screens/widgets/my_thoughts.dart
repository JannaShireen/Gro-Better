import 'package:flutter/material.dart';
import 'package:gro_better/screens/community/widgets/post_status.dart';
import 'package:gro_better/shared/constants.dart';

class ThoughtsTab extends StatelessWidget {
  const ThoughtsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "You haven't posted anything yet.",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        kHeight10,
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(kButtonColor)),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CreatePostWidget()));
            },
            child: const Text(
              'Share your thoughts',
              style: TextStyle(color: kBackgroundColor),
            ))
      ],
    );
  }
}
