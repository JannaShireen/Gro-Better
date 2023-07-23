import 'package:flutter/material.dart';

import 'package:gro_better/provider/home_state.dart';
import 'package:gro_better/provider/user_provider.dart';
import 'package:gro_better/services/auth.dart';

import 'package:gro_better/shared/constants.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }

  addData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    //  final currentuserId = FirebaseAuth.instance.currentUser!.uid;
    final AuthService auth = AuthService();

    return Consumer<HomeState>(
      builder: (context, bottomNavState, _) {
        return Scaffold(
          body: Center(
            child: bottomNavState.widgetOptions
                .elementAt(bottomNavState.selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            enableFeedback: true,
            backgroundColor: const Color.fromARGB(255, 191, 139, 91),
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
