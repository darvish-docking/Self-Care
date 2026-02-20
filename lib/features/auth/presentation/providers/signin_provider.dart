import 'package:flutter/material.dart';

class SigninFormProvider extends ChangeNotifier {
  // ------------------------
  // Fields
  // ------------------------

  String _email = '';
  String _password = '';

  String? _emailError;
  String? _passwordError;

  bool _isLoading = false;

  // ------------------------
  // Getters
  // ------------------------

  String get email => _email;
  String get password => _password;

  String? get emailError => _emailError;
  String? get passwordError => _passwordError;

  bool get isLoading => _isLoading;

  // ------------------------
  // Update Methods
  // ------------------------

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

  // ------------------------
  // Validation Logic
  // (Copied pattern from SignupFormProvider)
  // ------------------------

  String? _validateEmail(String value) {
    if (value.isEmpty) return "Email is required";
    if (!value.contains('@')) return "Invalid email";
    return null;
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) return "Password is required";
    if (value.length < 6) return "Password too short";
    return null;
  }

  // ------------------------
  // Submit Logic
  // ------------------------

  Future<bool> submit() async {
    // Validate all fields
    _emailError = _validateEmail(_email);
    _passwordError = _validatePassword(_password);

    final isFormValid =
        _emailError == null &&
        _passwordError == null;

    notifyListeners();

    if (!isFormValid) return false;

    // Start loading
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();

    return true; // success
  }
}
