import 'package:flutter/material.dart';

class PostOptionsProvider with ChangeNotifier {
  bool _isAnonymous = false;

  bool get isAnonymous => _isAnonymous;

  void setAnonymous(bool value) {
    _isAnonymous = value;
    notifyListeners();
  }
}
