import 'package:flutter/material.dart';
import 'package:selfcare_mobileapp/features/enquiry/presentation/pages/payment.dart';

class PaymentProvider extends ChangeNotifier {

  PaymentMethods? _selectedPayment;

  PaymentMethods? get selectedPayment => _selectedPayment;

  void selectPayment(PaymentMethods method) {
    _selectedPayment = method;
    notifyListeners();
  }

}