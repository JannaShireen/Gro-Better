import 'package:flutter/material.dart';
import 'package:gro_better/model/user_info.dart';
import 'package:gro_better/provider/user_provider.dart';
import 'package:gro_better/screens/widgets/logout.dart';
import 'package:gro_better/screens/widgets/my_records.dart';
import 'package:gro_better/screens/widgets/my_thoughts.dart';
import 'package:gro_better/screens/widgets/profile_popup_menu.dart';
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
        backgroundColor: const Color.fromARGB(255, 66, 34, 5),
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
          const ProfilePopupMenu(),
          LogoutButton(auth: auth),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(gradient: gradientColor),
          child: const Column(
            children: [
              TopSection(),
              DividerTeal,
              DefaultTabController(
                length: 2,
                child: Column(
                  children: [
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
      ),
    );
  }
}
