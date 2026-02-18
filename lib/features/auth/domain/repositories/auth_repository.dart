import '../entities/registration_entity.dart';

abstract class AuthRepository {
  Future<void> register(RegistrationEntity entity);
}
