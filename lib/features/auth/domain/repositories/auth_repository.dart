import 'package:country_picker/src/country.dart';
import 'package:selfcare_mobileapp/features/auth/data/models/app_user.dart';
import 'package:selfcare_mobileapp/features/auth/domain/entities/user.dart';
import 'package:selfcare_mobileapp/features/auth/domain/entities/user_role.dart';

import '../entities/registration_entity.dart';



abstract class AuthRepository {

  Future<void> register(RegistrationEntity entity);

  Future<void> registerUser({
    required String email,
    required String password,
    required String fullName, 
    required UserRole role, 
    Gender? gender, 
    DateTime? dateOfBirth, 
    Country? location,
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



  Future<void> loginUser({
  required String email,
  required String password,
});


Future<UserEntity?> getCurrentUser();


  Future<void> logout();
}
