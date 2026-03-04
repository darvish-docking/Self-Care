class AppUser {
  final String id;
  final String email;
  final String displayName;
  final String role;
  final String? gender;
  final DateTime? dateOfBirth;
  final String? location;

  AppUser({
    required this.id,
    required this.email,
    required this.displayName,
    required this.role,
    this.gender,
    this.dateOfBirth,
    this.location,
  });

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'],
      email: map['email'],
      displayName: map['displayName'],
      role: map['role'],
      gender: map['gender'],
      location: map['location'],
      dateOfBirth: map['dateOfBirth'] != null
          ? DateTime.parse(map['dateOfBirth'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'role': role,
      'gender': gender,
      'location': location,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
    };
  }
}