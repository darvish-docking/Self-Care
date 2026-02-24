import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {

  int _selectedBottomIndex = 0;
  bool _isFilterActive = false;
  String _selectedChip = "#teeth";

  int get selectedBottomIndex => _selectedBottomIndex;
  bool get isFilterActive => _isFilterActive;
  String get selectedChip => _selectedChip;

  void changeBottomIndex(int index) {
    _selectedBottomIndex = index;
    notifyListeners();
  }

  void toggleFilter() {
    _isFilterActive = !_isFilterActive;
    notifyListeners();
  }

  void selectChip(String chip) {
    _selectedChip = chip;
    notifyListeners();
  }
}
