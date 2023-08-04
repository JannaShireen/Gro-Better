import 'package:flutter/material.dart';
import 'package:gro_better/screens/profile/login_again.dart';
import 'package:gro_better/screens/widgets/about_us.dart';
import 'package:gro_better/screens/widgets/my_records.dart';
import 'package:gro_better/screens/widgets/my_thoughts.dart';
import 'package:gro_better/screens/widgets/top_section.dart';
import 'package:gro_better/services/auth.dart';
import 'package:gro_better/shared/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // UserDetails userInfo = Provider.of<UserProvider>(context).getUser!;
    // final String username = userInfo.email.split('@')[0];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
        title: Text(
          'Gro Better',
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
                const PopupMenuItem(value: 2, child: Text('Feedback')),
                const PopupMenuItem(value: 3, child: Text('About us')),
                const PopupMenuItem(value: 4, child: Text('Log out')),
              ];
            },
            onSelected: (value) {
              if (value == 0) {
                _showDeleteAccountConfirmationDialog(context);
              } else if (value == 1) {
              } else if (value == 2) {
                _feedback();
              } else if (value == 3) {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const AboutUs()));
              } else if (value == 4) {
                _showLogoutConfirmationDialog(context);
                ZegoUIKitPrebuiltCallInvitationService().uninit();
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
                        MyRecords(),
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

  Future _feedback() async {
    const url =
        'mailto:jannashireen@gmail.com?subject=Review on Gro Better App &body= I have a concern';
    Uri uri = Uri.parse(url);

    await launchUrl(uri);
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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginAgain()));
                  // Navigator.of(context).pop(); // Close the dialog
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
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
