import 'package:flutter/material.dart';
import 'package:gro_better/model/user.dart';
import 'package:gro_better/screens/authenticate/authenticate.dart';
import 'package:gro_better/screens/community/bottom_navigation_bar/bottom_navigation_bar.dart';

import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return HomeScreen();

      //return either home or authenticate widget
    }
  }
}
