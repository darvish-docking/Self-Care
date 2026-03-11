import 'package:flutter/material.dart';




class OtpProvider extends ChangeNotifier {
  final List<String> _otp = ['', '', '', ''];
  List<String> get otp => _otp;

  bool _showError = false;
  bool get showError => _showError;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String get enteredOtp => _otp.join();

  int _secondsRemaining = 60;
  int get secondsRemaining => _secondsRemaining;

  bool _isDisposed = false;


  bool get canResend => _secondsRemaining == 0;

  bool _isVerifying = false;
  bool get isVerifying => _isVerifying;

  void setDigit(int index, String value) {
    _otp[index] = value;

    // Remove error automatically when user starts fixing input
    if (_showError && enteredOtp.length == 4) {
      _showError = false;
    }

    notifyListeners();
  }


  bool validateOtp() {

    if (enteredOtp.isEmpty) {
    _showError = true;
    _errorMessage = "OTP cannot be empty";
    notifyListeners();
    return false;
  }
    
    if (enteredOtp.length < 4) {
      _showError = true;
      _errorMessage = "Please enter the 4-digit OTP";
      notifyListeners();
      return false;
    }
    _showError = false;
    notifyListeners();
    return true;
  }


  void startTimer() {
    _secondsRemaining = 60;
    notifyListeners();

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));

      // if (_secondsRemaining > 0) {
      //   _secondsRemaining--;
      //   notifyListeners();
      //   return true;
      // }
      // return false;

      if (_isDisposed) return false;

      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        if (!_isDisposed) notifyListeners();
        return true;
      }

      return false;

    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Future<bool> verifyOtp() async {
    print('inside verifyotp function');
    if (!validateOtp()) return false;

    _isVerifying = true;
    notifyListeners();

    // Your API call here in try-catch block
    // await Future.delayed(const Duration(seconds: 2));

    // Dummy OTP for now
  const dummyOtp = "1234";

  if (enteredOtp == dummyOtp) {
    _isVerifying = false;
    _errorMessage = null;
    notifyListeners();
    return true;
  } else {
    _isVerifying = false;
    _showError = true;
    _errorMessage = "Invalid OTP";
    notifyListeners();
    return false;
  }

    // _isVerifying = false;
    // notifyListeners();
    // return true;
  }



  void resendCode() {
    if (canResend) {
      startTimer();
    }
  }
}
