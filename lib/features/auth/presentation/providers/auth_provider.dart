import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

import 'package:selfcare_mobileapp/features/auth/domain/entities/user_role.dart';


class SignupFormProvider extends ChangeNotifier {

//userrole
  UserRole _selectedUserRole = UserRole.patient;

  UserRole get selectedUserRole => _selectedUserRole;

  void userRoleSelection (UserRole role){
    _selectedUserRole = role;
    notifyListeners();
  }



//gender
Gender? _selectedGender = Gender.male;

  Gender? get selectedGender => _selectedGender;

  void selectGender(Gender gender) {
    _selectedGender = gender;
    notifyListeners();
  }




//dob
final dayController = TextEditingController();
  final monthController = TextEditingController();
  final yearController = TextEditingController();

    int? get _day => int.tryParse(dayController.text);
    int? get _month => int.tryParse(monthController.text);
    int? get _year => int.tryParse(yearController.text);


  final dayFocus = FocusNode();
  final monthFocus = FocusNode();
  final yearFocus = FocusNode();

  void onChanged() => notifyListeners();

  String? get dayError => _validateDay(_day);
  String? get monthError => _validateMonth(_month);
  String? get yearError => _validateYear(_year);


  DateTime? get selectedDob {
    if (dayError != null || monthError != null || yearError != null) return null;

    final d = _day;
    final m = _month;
    final y = _year;
    final date = DateTime(y!, m!, d!);

    // Prevent invalid combinations like 31 Feb
    if (date.year != y || date.month != m || date.day != d) {
      return null;
    }

    return date;
  }


  bool get isDobValid =>
      dayError == null &&
      monthError == null &&
      yearError == null &&
      dayController.text.isNotEmpty &&
      monthController.text.isNotEmpty &&
      yearController.text.isNotEmpty;

  String? _validateDay(int? d) {
    if (d == null) return null;
    if (d < 1 || d > 31) return "1-31";
    return null;
  }

  String? _validateMonth(int? m) {
    if (m == null) return null;
    if (m < 1 || m > 12) return "1-12";
    return null;
  }

  String? _validateYear(int? y) {
    if (y == null) return null;
    if (y < 1900 || y > DateTime.now().year) {
      return "Invalid";
    }
    return null;
  }




//location
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



  bool validateAll() {
    // print('Role: $selectedUserRole - gender: ${selectedGender?.label} - DOB: ${selectedDob} - Location: ${selectedCountry}');

    return selectedGender != null &&
           selectedDob != null &&
           selectedCountry != null &&
           selectedUserRole != null;
  }
}
