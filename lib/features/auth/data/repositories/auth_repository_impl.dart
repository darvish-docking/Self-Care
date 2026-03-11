import 'package:country_picker/country_picker.dart';
import 'package:selfcare_mobileapp/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:selfcare_mobileapp/features/auth/data/models/app_user.dart';
import 'package:selfcare_mobileapp/features/auth/data/models/registration_dto.dart';
import 'package:selfcare_mobileapp/features/auth/domain/entities/registration_entity.dart';
import 'package:selfcare_mobileapp/features/auth/domain/entities/user.dart';
import 'package:selfcare_mobileapp/features/auth/domain/entities/user_role.dart';
import 'package:selfcare_mobileapp/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl(this.remoteDatasource);

  @override
  Future<void> registerUser({
    required UserRole role, 
    Gender? gender, 
    DateTime? dateOfBirth, 
    Country? location,
    required String email,
    required String password,
    required String fullName,
  }) async {
    final dto = RegistrationDto(
      role: role.name,
      gender: gender?.name ?? '',
      dob: dateOfBirth?.toIso8601String() ?? '',
      name: fullName,
      email: email,
      password: password, 
      location: location?.displayName?? '',
    );

    await remoteDatasource.registerUser(dto);
  }

  // @override
  // Future<AppUser> registerPatient({
  //   required String email,
  //   required String password,
  //   required String fullName,
  // }) {
  //   return _remoteDatasource.registerPatient(
  //     email: email,
  //     password: password,
  //     displayName: fullName,
  //     role: 'patient',
  //   );
  // }

  // @override
  // Future<AppUser> registerDoctor({
  //   required String email,
  //   required String password,
  //   required String fullName,
  // }) {
  //   return _remoteDatasource.registerDoctor(
  //     email: email,
  //     password: password,
  //     displayName: fullName,
  //     role: 'doctor',
  //   );
  // }


  @override
Future<void> loginUser({
  required String email,
  required String password,
}) async {
  await remoteDatasource.loginUser(
    email: email,
    password: password,
  );
}

  // @override
  // Future<AppUser> login({
  //   required String email,
  //   required String password,
  // }) {
  //   return remoteDatasource.login(
  //     email: email,
  //     password: password,
  //   );
  // }



  @override
  Future<UserEntity?> getCurrentUser() async {
    return await remoteDatasource.getCurrentUser();
  }


  @override
  Future<void> logout() {
    return remoteDatasource.logout();
  }

  @override
  Future<void> register(RegistrationEntity entity) {
    // TODO: implement register
    throw UnimplementedError();
  }
}