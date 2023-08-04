import 'package:flutter/material.dart';
import 'package:gro_better/model/user.dart';
import 'package:gro_better/provider/user_provider.dart';
import 'package:gro_better/screens/authenticate/authenticate.dart';
import 'package:gro_better/screens/community/bottom_navigation_bar/bottom_navigation_bar.dart';

import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    void addData() async {
      UserProvider userProvider = Provider.of(context, listen: false);
      await userProvider.refreshUser();
    }

    final user = Provider.of<UserModel?>(context);
    if (user == null) {
      return const Authenticate();
    } else {
      addData();
      return const HomeScreen();

      //return either home or authenticate widget
    }
  }
}
