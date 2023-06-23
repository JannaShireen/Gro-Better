import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  final String? imageUrl;
  const ProfilePic({
    super.key,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 35,
        backgroundImage: AssetImage(
          "assets/images/$imageUrl",
        ));

    // ClipRRect(
    //   borderRadius: BorderRadius.circular(5),
    //   child: Container(
    //     margin: const EdgeInsets.only(left: 15),
    //     height: 35,
    //     width: 40,
    //     child: Image.asset(
    //       'assets/images/$imageUrl',
    //       fit: BoxFit.cover,
    //     ),
    //   ),
    // );
  }
}
