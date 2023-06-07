import 'package:flutter/material.dart';
import 'package:gro_better/screens/community/community.dart';
import 'package:gro_better/screens/experts/experts.dart';
import 'package:gro_better/screens/explore/explore.dart';
import 'package:gro_better/screens/profile/profile.dart';
import 'package:gro_better/shared/constants.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeState>(
      create: (_) => HomeState(),
      child: Consumer<HomeState>(
        builder: (context, bottomNavState, _) {
          return Scaffold(
            body: Center(
              child: bottomNavState.widgetOptions
                  .elementAt(bottomNavState.selectedIndex),
            ),
            bottomNavigationBar: BottomNavigationBar(
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
                  icon: Icon(Icons.search, color: kPrimaryColor),
                  label: 'Explore',
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
      ),
    );
  }
}

class HomeState extends ChangeNotifier {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    CommunityScreen(),
    const ExploreScreen(),
    const ExpertScreen(),
    const ProfileScreen(),
  ];

  int get selectedIndex => _selectedIndex;
  List<Widget> get widgetOptions => _widgetOptions;

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
