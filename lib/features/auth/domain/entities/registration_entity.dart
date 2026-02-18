import 'user_role.dart';

class RegistrationEntity {
  final UserRole role;
  final Gender gender;
  final DateTime dob;
  final String name;
  final String email;
  final String password;

  RegistrationEntity({
    required this.role,
    required this.gender,
    required this.dob,
    required this.name,
    required this.email,
    required this.password,
  });
}
