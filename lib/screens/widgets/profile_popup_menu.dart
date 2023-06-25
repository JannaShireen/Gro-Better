import 'package:flutter/material.dart';

class ProfilePopupMenu extends StatelessWidget {
  const ProfilePopupMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        // add icon, by default "3 dot" icon
        // icon: Icon(Icons.book)
        itemBuilder: (context) {
      return [
        const PopupMenuItem<int>(
          value: 0,
          child: Text("Settings"),
        ),
        const PopupMenuItem<int>(
          value: 1,
          child: Text("Bookmark"),
        ),
        const PopupMenuItem<int>(
          value: 2,
          child: Text("Contact us"),
        ),
      ];
    }, onSelected: (value) {
      if (value == 0) {
        print("Settings is selected.");
      } else if (value == 1) {
        print("Bookmarked posts appear here.");
      } else if (value == 2) {
        print("Contact me via email.");
      }
    });
  }
}
