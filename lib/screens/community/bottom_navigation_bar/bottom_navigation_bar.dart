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
          bottomNavigationBar: BottomNavigationBar(
            enableFeedback: true,
            backgroundColor: kPrimaryColor,
            selectedItemColor: kDefaultIconDarkColor,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: kBackgroundColor,
                ),
                label: 'Community',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.medical_services, color: kBackgroundColor),
                label: 'Experts',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message, color: kBackgroundColor),
                label: 'Conversations',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, color: kBackgroundColor),
                label: 'Profile',
              ),
            ],
            currentIndex: bottomNavState.selectedIndex,
            onTap: (index) {
              bottomNavState.onItemTapped(index);
            },
          ),
        );
      },
    );
  }
}
