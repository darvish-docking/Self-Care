enum UserRole {
  doctor, patient
}

// enum Gender {
//   Male,
//   Female,
// }

enum Gender {
  male,
  female;

  String get label {
    switch (this) {
      case Gender.male:
        return "Male";
      case Gender.female:
        return "Female";
    }
  }

  String get iconPath {
    switch (this) {
      case Gender.male:
        return 'assets/icons/icon male.svg';
      case Gender.female:
        return 'assets/icons/icon female.svg';
    }
  }
}
