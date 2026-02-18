
import 'package:selfcare_mobileapp/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:selfcare_mobileapp/features/auth/data/models/registration_dto.dart';
import 'package:selfcare_mobileapp/features/auth/domain/entities/registration_entity.dart';
import 'package:selfcare_mobileapp/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {

  final AuthRemoteDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<void> register(RegistrationEntity entity) async {
    final dto = RegistrationDto.fromEntity(entity);
    await datasource.register(dto);
  }
}
