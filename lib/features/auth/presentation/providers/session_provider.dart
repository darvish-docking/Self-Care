import 'package:flutter/material.dart';
import 'package:selfcare_mobileapp/features/auth/domain/entities/user.dart';
import 'package:selfcare_mobileapp/features/auth/domain/usecases/get_current_user_usecase.dart';

class SessionProvider extends ChangeNotifier {

  final GetCurrentUserUseCase _getCurrentUser;

  SessionProvider(this._getCurrentUser);

  UserEntity? _user;
  bool _isLoading = false;

  UserEntity? get user => _user;
  bool get isLoading => _isLoading;

  Future<void> loadUser() async {

    _isLoading = true;
    notifyListeners();

    _user = await _getCurrentUser();

    _isLoading = false;
    notifyListeners();
  }
}