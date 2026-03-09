import 'package:firebase_auth/firebase_auth.dart';
import 'package:selfcare_mobileapp/features/auth/data/models/app_user.dart';

import '../entities/registration_entity.dart';



abstract class AuthRepository {

  Future<void> register(RegistrationEntity entity);

  Future<void> registerUser({
    required String email,
    required String password,
    required String fullName,
  });
  
  // Future<AppUser> registerPatient({
  //   required String email,
  //   required String password,
  //   required String fullName,
  // });

  // Future<AppUser> registerDoctor({
  //   required String email,
  //   required String password,
  //   required String fullName,
  // });

  Future<AppUser> login({
    required String email,
    required String password,
  });

  Future<void> logout();
}