import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:gro_better/provider/home_state.dart';
import 'package:gro_better/services/zego/zego_services.dart';

import 'package:gro_better/shared/constants.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    ZegoServices(ctx: context).onUserLogin();
  }

  @override
  Widget build(BuildContext context) {
    //  final currentuserId = FirebaseAuth.instance.currentUser!.uid;

    return Consumer<HomeState>(
      builder: (context, bottomNavState, _) {
        return Scaffold(
          body: Center(
            child: bottomNavState.widgetOptions
                .elementAt(bottomNavState.selectedIndex),
          ),
          bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: kBackgroundColor,
              animationDuration: const Duration(milliseconds: 300),
              color: kPrimaryColor,
              onTap: (index) {
                bottomNavState.onItemTapped(index);
              },

              // currentIndex: bottomNavState.selectedIndex,
              items: const [
                Icon(Icons.home_filled),
                Icon(Icons.medical_services),
                Icon(Icons.message),
                Icon(Icons.person)
              ]),
        );
      },
    );
  }
}
