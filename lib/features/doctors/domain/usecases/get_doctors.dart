

import 'package:selfcare_mobileapp/features/doctors/domain/entities/doctor.dart';
import 'package:selfcare_mobileapp/features/doctors/domain/repositories/doctor_repository.dart';

class GetDoctors {
  final DoctorRepository repository;

  GetDoctors(this.repository);

  Future<List<Doctor>> call() {
    return repository.getDoctors();
  }
}