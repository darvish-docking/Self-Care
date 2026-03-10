import 'package:country_picker/src/country.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:selfcare_mobileapp/features/auth/data/models/registration_dto.dart';
import 'package:selfcare_mobileapp/features/auth/domain/entities/user_role.dart';
import '../models/app_user.dart';

class AuthRemoteDatasource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRemoteDatasource(this.auth, this.firestore);


  Future<void> registerUser(RegistrationDto dto) async {

  final credential = await auth.createUserWithEmailAndPassword(
    email: dto.email,
    password: dto.password,
  );

  final uid = credential.user!.uid;

  await firestore.collection('users').doc(uid).set({
    "id": uid,
    "displayName": dto.name,
    "email": dto.email,
    "role": dto.role,
    "gender": dto.gender,
    "location": dto.location,
    "dateOfBirth": dto.dob,
  });
}

  // Future<AppUser> registerPatient({
  //   required String email,
  //   required String password,
  //   required String displayName,
  //   required String role,
  // }) async {
  //   final credential = await _auth.createUserWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );

  //   final firebaseUser = credential.user!;
  //   final uid = firebaseUser.uid;

  //   final appUser = AppUser(
  //     id: uid,
  //     email: email,
  //     displayName: displayName,
  //     role: role,
  //   );

  //   await _firestore.collection('users').doc(uid).set({
  //     ...appUser.toMap(),
  //     'createdAt': FieldValue.serverTimestamp(),
  //     'isActive': true,
  //   });

  //   return appUser;
  // }





  // Future<AppUser> registerDoctor({
  //   required String email,
  //   required String password,
  //   required String displayName,
  //   required String role,
  // }) async {
  //   final credential = await _auth.createUserWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );

  //   final firebaseUser = credential.user!;
  //   final uid = firebaseUser.uid;

  //   final appUser = AppUser(
  //     id: uid,
  //     email: email,
  //     displayName: displayName,
  //     role: role,
  //   );

  //   await _firestore.collection('users').doc(uid).set({
  //     ...appUser.toMap(),
  //     'createdAt': FieldValue.serverTimestamp(),
  //     'isActive': true,
  //   });

  //   return appUser;
  // }





  Future<AppUser> login({
    required String email,
    required String password,
  }) async {
    final credential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = credential.user!.uid;

    final doc = await firestore.collection('users').doc(uid).get();

    if (!doc.exists) {
      throw Exception("User document not found");
    }

    return AppUser.fromMap(doc.data()!);
  }

  Future<void> logout() async {
    await auth.signOut();
  }
}