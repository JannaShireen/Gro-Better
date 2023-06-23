import 'package:flutter/material.dart';
import 'package:gro_better/provider/home_state.dart';

import 'package:gro_better/shared/constants.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeState>(
      builder: (context, bottomNavState, _) {
        return Scaffold(
          body: Center(
            child: bottomNavState.widgetOptions
                .elementAt(bottomNavState.selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            enableFeedback: true,
            backgroundColor: kDefaultIconLightColor,
            selectedItemColor: kDefaultIconDarkColor,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: kPrimaryColor,
                ),
                label: 'Community',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.medical_services, color: kPrimaryColor),
                label: 'Experts',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, color: kPrimaryColor),
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
