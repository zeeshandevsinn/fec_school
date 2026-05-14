import 'package:flutter/material.dart';

class SwitchingProvider with ChangeNotifier {
  int _isValue = 0;

  get isValue => _isValue;

  void isSwitching(int? index) {
    _isValue = index!;
    notifyListeners();
  }
}
