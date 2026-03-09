import '../entities/registration_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUserUseCase {
  final AuthRepository repository;

  RegisterUserUseCase(this.repository);

  Future<void> call({
    required String email,
    required String password,
    required String fullName,
  }) async {
    await repository.registerUser(
      email: email,
      password: password,
      fullName: fullName,
    );
  }
}