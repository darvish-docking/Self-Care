import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/app_user.dart';

class AuthRemoteDatasource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRemoteDatasource(this._auth, this._firestore);

  Future<AppUser> register({
    required String email,
    required String password,
    required String displayName,
    required String role,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final firebaseUser = credential.user!;
    final uid = firebaseUser.uid;

    final appUser = AppUser(
      id: uid,
      email: email,
      displayName: displayName,
      role: role,
    );

    await _firestore.collection('users').doc(uid).set({
      ...appUser.toMap(),
      'createdAt': FieldValue.serverTimestamp(),
      'isActive': true,
    });

    return appUser;
  }

  Future<AppUser> login({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = credential.user!.uid;

    final doc = await _firestore.collection('users').doc(uid).get();

    if (!doc.exists) {
      throw Exception("User document not found");
    }

    return AppUser.fromMap(doc.data()!);
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}