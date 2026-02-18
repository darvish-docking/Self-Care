
import 'package:selfcare_mobileapp/features/auth/domain/entities/registration_entity.dart';

class RegistrationDto {
  final String role;
  final String gender;
  final String dob;
  final String name;
  final String email;
  final String password;

  RegistrationDto({
    required this.role,
    required this.gender,
    required this.dob,
    required this.name,
    required this.email,
    required this.password,
  });

  factory RegistrationDto.fromEntity(RegistrationEntity entity) {
    return RegistrationDto(
      role: entity.role.name,
      gender: entity.gender.toString(),
      dob: entity.dob.toIso8601String(),
      name: entity.name,
      email: entity.email,
      password: entity.password,
    );
  }

  Map<String, dynamic> toJson() => {
        "role": role,
        "gender": gender,
        "dob": dob,
        "name": name,
        "email": email,
        "password": password,
      };
}
