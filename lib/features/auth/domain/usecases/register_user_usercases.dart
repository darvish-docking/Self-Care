import '../entities/registration_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUserUseCase {
  
  final AuthRepository repository;

  RegisterUserUseCase(this.repository);

  Future<void> call(RegistrationEntity entity) {
    return repository.register(entity);
  }


}
