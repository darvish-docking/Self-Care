
import 'package:selfcare_mobileapp/features/auth/domain/entities/registration_entity.dart';

class RegistrationDto {
  final String role;
  final String gender;
  final String dob;
  final String name;
  final String email;
  final String password;
  final String location;

  RegistrationDto({
    required this.role,
    required this.gender,
    required this.dob,
    required this.name,
    required this.email,
    required this.password,
    required this.location,
  });

  factory RegistrationDto.fromEntity(RegistrationEntity entity) {
    return RegistrationDto(
      role: entity.role.name,
      gender: entity.gender.name,
      dob: entity.dob.toIso8601String(),
      name: entity.name,
      email: entity.email,
      password: entity.password,
      location: entity.location.displayName,
    );
  }

  Map<String, dynamic> toJson() => {
        "role": role,
        "gender": gender,
        "dob": dob,
        "name": name,
        "email": email,
        "password": password,
        "location": location,
      };
}