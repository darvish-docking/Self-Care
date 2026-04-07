

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:selfcare_mobileapp/features/home/presentation/models/doctor_models.dart';

class DoctorFirestoreDataSource {
  final FirebaseFirestore firestore;

  DoctorFirestoreDataSource(this.firestore);

  Future<List<DoctorModel>> getDoctors() async {
    final snapshot = await firestore.collection('doctors').get();

    return snapshot.docs
        .map((doc) => DoctorModel.fromFirestore(doc))
        .toList();
  }
}
