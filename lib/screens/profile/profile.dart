import 'package:flutter/material.dart';
import 'package:gro_better/model/user_info.dart';
import 'package:gro_better/provider/user_provider.dart';

import 'package:gro_better/screens/widgets/my_records.dart';
import 'package:gro_better/screens/widgets/my_thoughts.dart';
import 'package:gro_better/screens/widgets/top_section.dart';
import 'package:gro_better/services/auth.dart';
import 'package:gro_better/shared/constants.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService auth = AuthService();
    UserDetails? userInfo = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
        title: Text(
          '${userInfo?.email}'.split('@')[0],
          //  ' ${user.email}',
          //' ${document!['Email']}'.split("@")[0],
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
        ),
        actions: <Widget>[
          PopupMenuButton(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(14))),
            itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text('Delete My Account'),
                ),
                const PopupMenuItem(value: 1, child: Text('Bookmarks')),
                const PopupMenuItem(value: 2, child: Text('Contact us')),
                const PopupMenuItem(value: 3, child: Text('Share this app')),
                const PopupMenuItem(value: 4, child: Text('Log out')),
              ];
            },
            onSelected: (value) {
              if (value == 0) {
              } else if (value == 1) {
              } else if (value == 2) {
              } else if (value == 3) {
              } else if (value == 4) {
                _showLogoutConfirmationDialog(context);
              }
            },
          )

          //const ProfilePopupMenu(),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            TopSection(),
            DividerTeal,
            DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    labelColor: Colors.black,
                    tabs: [
                      Tab(
                        text: 'My Thoughts',
                      ),
                      Tab(text: 'My Records'),
                    ],
                  ),
                  SizedBox(
                    height: 500, // Adjust the height as needed
                    child: TabBarView(
                      children: [
                        ThoughtsTab(),
                        MyRecordsTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteAccountConfirmationDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(14))),
            title: const Text('Confirm Deletion?'),
            content: const Text(
                'Are you sure you want to delete your account permanently?'),
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
                  Navigator.of(context).pop(); // Close the dialog
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kButtonColor)),
                child: const Text('Delete Account'),
              ),
            ],
          );
        });
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    final AuthService auth = AuthService();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14))),
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to log out?'),
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
                await auth.Logout();
                Navigator.of(context).pop(); // Close the dialog
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kButtonColor)),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
