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

  String? _dayError ;
  String?  _monthError;
  String? _yearError;

  String? get dayError => _dayError;
  String? get monthError => _monthError;
  String? get yearError => _yearError;

  void validateDob() {
  _dayError = _validateDay(_day);
  _monthError = _validateMonth(_month);
  _yearError = _validateYear(_year);

  notifyListeners();

}


DateTime? get selectedDob {
  // If any field is null, return null immediately
  if (_day == null || _month == null || _year == null) {
    return null;
  }

  // Validate ranges
  if (_validateDay(_day) != null ||
      _validateMonth(_month) != null ||
      _validateYear(_year) != null) {
    return null;
  }

  final date = DateTime(_year!, _month!, _day!);

  // Prevent invalid combinations like 31 Feb
  if (date.year != _year ||
      date.month != _month ||
      date.day != _day) {
    return null;
  }

  return date;
}



  String? _validateDay(int? d) {
  if (d == null) return "Required";
  if (d < 1 || d > 31) return "1-31";
  return null;
}

String? _validateMonth(int? m) {
  if (m == null) return "Required";
  if (m < 1 || m > 12) return "1-12";
  return null;
}

String? _validateYear(int? y) {
  if (y == null) return "Required";
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



  bool validateOnContinue() {

    validateCountry();   // triggers country error if null
    validateDob();
    
    print('selectedDob = $selectedDob');
    

    return selectedDob != null &&
           selectedCountry != null ;
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

  const emailRegex =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

  if (!RegExp(emailRegex).hasMatch(value)) {
    return "Invalid email address";
  }

  return null;
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) {
    return "Password is required";
  }

  if (value.length < 8) {
    return "Minimum 8 characters required";
  }

  if (!RegExp(r'[A-Z]').hasMatch(value)) {
    return "At least one uppercase letter required";
  }

  if (!RegExp(r'[a-z]').hasMatch(value)) {
    return "At least one lowercase letter required";
  }

  if (!RegExp(r'[0-9]').hasMatch(value)) {
    return "At least one number required";
  }

  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
    return "At least one special character required";
  }

  return null;
  }

  // ---------------------------
  // Submit
  // ---------------------------

  Future<bool> submit() async {
    print('inside submit button in SIGNUP page');
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
