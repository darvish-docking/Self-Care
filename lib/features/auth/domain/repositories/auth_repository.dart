import 'package:firebase_auth/firebase_auth.dart';
import 'package:selfcare_mobileapp/features/auth/data/models/app_user.dart';

import '../entities/registration_entity.dart';



abstract class AuthRepository {

  Future<void> register(RegistrationEntity entity);
  
  Future<AppUser> registerPatient({
    required String email,
    required String password,
    required String displayName,
  });

  Future<AppUser> registerDoctor({
    required String email,
    required String password,
    required String displayName,
  });

  Future<AppUser> login({
    required String email,
    required String password,
  });

  Future<void> logout();
}