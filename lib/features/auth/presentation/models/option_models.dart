
import 'package:selfcare_mobileapp/features/auth/domain/entities/user_role.dart';

class OptionModel {
  final UserRole role;
  final String label;
  final String iconPath;
  final String description;

  OptionModel({required this.role, required this.label, required this.iconPath, required this.description});
}


class GenderModel{
  final String label;
  final String iconPath;

  GenderModel({required this.label, required this.iconPath});
}