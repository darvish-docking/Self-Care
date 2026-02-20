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




  // signup form

  String _fullName = '';
  String _email = '';
  String _password = '';

  String? _fullNameError;
  String? _emailError;
  String? _passwordError;

  bool _isLoading = false;

  // Getters
  String get fullName => _fullName;
  String get email => _email;
  String get password => _password;

  String? get fullNameError => _fullNameError;
  String? get emailError => _emailError;
  String? get passwordError => _passwordError;

  bool get isLoading => _isLoading;

  // ---------------------------
  // Update Methods
  // ---------------------------

  void updateFullName(String value) {
    _fullName = value;
    _fullNameError = _validateFullName(value);
    notifyListeners();
  }

  void updateEmail(String value) {
    _email = value;
    _emailError = _validateEmail(value);
    notifyListeners();
  }

  void updatePassword(String value) {
    _password = value;
    _passwordError = _validatePassword(value);
    notifyListeners();
  }

  // ---------------------------
  // Validation
  // ---------------------------

  String? _validateFullName(String value) {
    if (value.isEmpty) return "Full name is required";
    if (value.length < 3) return "Name too short";
    return null;
  }

  String? _validateEmail(String value) {
    if (value.isEmpty) return "Email is required";
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return "Invalid email address";
    }
    return null;
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) return "Password is required";
    if (value.length < 6) return "Minimum 6 characters required";
    return null;
  }

  // ---------------------------
  // Submit
  // ---------------------------

  Future<bool> submit() async {
    _fullNameError = _validateFullName(_fullName);
    _emailError = _validateEmail(_email);
    _passwordError = _validatePassword(_password);
    final isValid = validateTerms();


    notifyListeners();

    if (_fullNameError != null ||
        _emailError != null ||
        _passwordError != null || !isValid) {
      return false;
    }

    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();

    return true;
  }






// checkbox
bool _isTermsAccepted = false;
bool _showTermsError = false;

bool get isTermsAccepted => _isTermsAccepted;
bool get showTermsError => _showTermsError;

void toggleTerms(bool? value) {
  _isTermsAccepted = value ?? false;
  _showTermsError = false; // remove error when user interacts
  notifyListeners();
}

bool validateTerms() {
  if (!_isTermsAccepted) {
    _showTermsError = true;
    notifyListeners();
    return false;
  }
  return true;
}

}
