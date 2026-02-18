import 'package:dio/dio.dart';
import 'package:selfcare_mobileapp/features/auth/data/models/registration_dto.dart';

class AuthRemoteDatasource {

  final Dio dio;

  AuthRemoteDatasource(this.dio);

  Future<void> register(RegistrationDto dto) async {
    await dio.post(
      "/register",
      data: dto.toJson(),
    );
  }
}
