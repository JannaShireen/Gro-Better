import 'package:flutter/material.dart';
import 'package:gro_better/screens/community/community.dart';
import 'package:gro_better/screens/experts/experts.dart';
import 'package:gro_better/screens/profile/profile.dart';

class HomeState extends ChangeNotifier {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    CommunityScreen(),
    //ExpertScreen(),
    const DoctorsList(),
    const ProfileScreen(),
  ];

  int get selectedIndex => _selectedIndex;
  List<Widget> get widgetOptions => _widgetOptions;

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
