import 'package:flutter/material.dart';
import 'package:selfcare_mobileapp/features/auth/domain/usecases/login_user_usecase.dart';

class SigninFormProvider extends ChangeNotifier {

  final LoginUserUseCase loginUserUseCase;

  SigninFormProvider(this.loginUserUseCase);
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
    // await Future.delayed(const Duration(seconds: 2));

    try {

    await loginUserUseCase(
      email: _email,
      password: _password,
    );

    _isLoading = false;
    notifyListeners();

    return true;

  } catch (e) {

    _isLoading = false;
    notifyListeners();

    _passwordError = "Invalid email or password";
    return false;
  }

    // _isLoading = false;
    // notifyListeners();
    // return true; // success
  }
}
