import 'package:country_picker/country_picker.dart';
import 'package:selfcare_mobileapp/features/auth/domain/entities/user_role.dart';

import '../entities/registration_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUserUseCase {
  final AuthRepository repository;

  RegisterUserUseCase(this.repository);

  Future<void> call({
    required UserRole role,
    Gender? gender,
     DateTime? dateOfBirth,
     Country? location,
     required String email,
    required String password,
    required String fullName,
  }) async {
    await repository.registerUser(
      role: role,
      gender: gender,
      dateOfBirth: dateOfBirth,
      location: location,
      email: email,
      password: password,
      fullName: fullName,
    );
  }
}