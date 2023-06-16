import 'package:flutter/material.dart';

import 'package:gro_better/services/auth.dart';
import 'package:gro_better/shared/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService auth = AuthService();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
        title: Text(
          '@username',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
        ),
        actions: <Widget>[
          PopupMenuButton(
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
          }),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              textStyle: const TextStyle(color: Colors.green),
            ),
            onPressed: () async {
              await auth.Logout();
            },
            icon: const Icon(
              Icons.power_settings_new,
              color: Colors.white,
            ),
            label: const Text(
              'Log Out',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/janna_dp.jpg'),
                  ),
                  Column(
                    children: [
                      const Text(
                        'Janna Shireen',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      kHeight10,
                      const Location(),
                      kHeight10,
                      const Text(
                        'Student',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(kButtonColor)),
                        onPressed: () {},
                        child: const Text('Edit Profile'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            DividerTeal,
            DefaultTabController(
              length: 2,
              child: Column(
                children: const [
                  TabBar(
                    tabs: [
                      Tab(text: 'My Thoughts'),
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
}

class Location extends StatelessWidget {
  const Location({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(
          Icons.location_on_outlined,
          color: Colors.white,
        ),
        Text(
          'Kerala, India',
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}

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
            onPressed: () {},
            child: const Text(
              'Share your thoughts',
              style: TextStyle(color: kBackgroundColor),
            ))
      ],
    );
  }
}

class MyRecordsTab extends StatelessWidget {
  const MyRecordsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('My Records Tab Content'),
    );
  }
}
