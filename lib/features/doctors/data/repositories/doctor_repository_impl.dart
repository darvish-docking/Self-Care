

import 'package:selfcare_mobileapp/features/doctors/data/datasources/doctor_firebase_datasource.dart';
import 'package:selfcare_mobileapp/features/doctors/domain/entities/doctor.dart';
import 'package:selfcare_mobileapp/features/doctors/domain/repositories/doctor_repository.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final DoctorFirestoreDataSource datasource;

  DoctorRepositoryImpl(this.datasource);

  @override
  Future<List<Doctor>> getDoctors() {
    return datasource.getDoctors();
  }
}