import 'package:flutter/material.dart';

class OtpProvider extends ChangeNotifier {
  final List<String> _otp = ['', '', '', ''];
  List<String> get otp => _otp;

  bool _showError = false;
  bool get showError => _showError;

  String get enteredOtp => _otp.join();

  int _secondsRemaining = 60;
  int get secondsRemaining => _secondsRemaining;

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
    
    if (enteredOtp.length < 4) {
      _showError = true;
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
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        notifyListeners();
        return true;
      }
      return false;
    });
  }

  Future<void> verifyOtp() async {
    if (!validateOtp()) return;

    _isVerifying = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _isVerifying = false;
    notifyListeners();
  }

  void resendCode() {
    if (canResend) {
      startTimer();
    }
  }
}
