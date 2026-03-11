
import 'package:selfcare_mobileapp/features/auth/domain/entities/user.dart';
import 'package:selfcare_mobileapp/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<UserEntity?> call() async {
    return await repository.getCurrentUser();
  }
}