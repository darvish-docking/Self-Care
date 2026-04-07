

import 'package:selfcare_mobileapp/features/doctors/domain/entities/doctor.dart';

abstract class DoctorRepository {
  Future<List<Doctor>> getDoctors();
}