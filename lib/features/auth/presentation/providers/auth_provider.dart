import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

import 'package:selfcare_mobileapp/features/auth/domain/entities/user_role.dart';

class UserRoleProviders extends ChangeNotifier{

  UserRole _selectedUserRole = UserRole.patient;

  UserRole get selectedUserRole => _selectedUserRole;

  void userRoleSelection (UserRole role){
    _selectedUserRole = role;
    notifyListeners();
  }
}


class GenderProviders extends ChangeNotifier{

  Gender? _selectedGender = Gender.male;

  Gender? get selectedGender => _selectedGender;

  void selectGender(Gender gender) {
    _selectedGender = gender;
    notifyListeners();
  }

}


//start_4.dart file
class DobProvider extends ChangeNotifier {
  final dayController = TextEditingController();
  final monthController = TextEditingController();
  final yearController = TextEditingController();

  final dayFocus = FocusNode();
  final monthFocus = FocusNode();
  final yearFocus = FocusNode();

  void onChanged() => notifyListeners();

  String? get dayError => _validateDay(dayController.text);
  String? get monthError => _validateMonth(monthController.text);
  String? get yearError => _validateYear(yearController.text);

  bool get isDobValid =>
      dayError == null &&
      monthError == null &&
      yearError == null &&
      dayController.text.isNotEmpty &&
      monthController.text.isNotEmpty &&
      yearController.text.isNotEmpty;

  String? _validateDay(String value) {
    if (value.isEmpty) return null;
    final d = int.tryParse(value);
    if (d == null || d < 1 || d > 31) return "1-31";
    return null;
  }

  String? _validateMonth(String value) {
    if (value.isEmpty) return null;
    final m = int.tryParse(value);
    if (m == null || m < 1 || m > 12) return "1-12";
    return null;
  }

  String? _validateYear(String value) {
    if (value.isEmpty) return null;
    final y = int.tryParse(value);
    if (y == null || y < 1900 || y > DateTime.now().year) {
      return "Invalid";
    }
    return null;
  }
}



class LocationProvider extends ChangeNotifier {
  Country? _selectedCountry;
  String? _countryError;

  Country? get selectedCountry => _selectedCountry;
  String? get countryError => _countryError;

  bool get isCountryValid => _selectedCountry != null;

  void setCountry(Country country) {
    _selectedCountry = country;
    _countryError = null;
    notifyListeners();
  }

  void validateCountry() {
    if (_selectedCountry == null) {
      _countryError = "Please select your country";
      notifyListeners();
    }
  }
}
