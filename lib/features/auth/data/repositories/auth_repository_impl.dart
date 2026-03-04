import 'package:selfcare_mobileapp/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:selfcare_mobileapp/features/auth/data/models/app_user.dart';
import 'package:selfcare_mobileapp/features/auth/domain/entities/registration_entity.dart';
import 'package:selfcare_mobileapp/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _remoteDatasource;

  AuthRepositoryImpl(this._remoteDatasource);

  @override
  Future<AppUser> registerPatient({
    required String email,
    required String password,
    required String displayName,
  }) {
    return _remoteDatasource.register(
      email: email,
      password: password,
      displayName: displayName,
      role: 'patient',
    );
  }

  @override
  Future<AppUser> registerDoctor({
    required String email,
    required String password,
    required String displayName,
  }) {
    return _remoteDatasource.register(
      email: email,
      password: password,
      displayName: displayName,
      role: 'doctor',
    );
  }

  @override
  Future<AppUser> login({
    required String email,
    required String password,
  }) {
    return _remoteDatasource.login(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logout() {
    return _remoteDatasource.logout();
  }

  @override
  Future<void> register(RegistrationEntity entity) {
    // TODO: implement register
    throw UnimplementedError();
  }
}