import '../repositories/auth_repository.dart';

class LoginUserUseCase {
  final AuthRepository repository;

  LoginUserUseCase(this.repository);

  Future<void> call({
    required String email,
    required String password,
  }) async {
    await repository.loginUser(
      email: email,
      password: password,
    );
  }
}