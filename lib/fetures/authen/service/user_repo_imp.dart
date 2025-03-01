import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutterbloc/fetures/authen/model/user.dart';
import 'package:firebase_flutterbloc/fetures/authen/service/user_repo.dart';

class UserRepoImp extends UserRepo {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  UserRepoImp({FirebaseAuth? firbaseAuth, FirebaseFirestore? firestore})
    : _firebaseAuth = firbaseAuth ?? FirebaseAuth.instance,
      _firestore = firestore ?? FirebaseFirestore.instance; // Assign Firestore
  @override
  Future<void> setUserData(UserModel user) async {
    try {
      await _firestore
          .collection('users')
          .doc(user.userId)
          .set(user.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<UserModel> signUp(UserModel usermodel, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: usermodel.email,
        password: password,
      );
      usermodel = usermodel.copyWith(userId: user.user!.uid);
      return usermodel;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser;
    });
  }

  @override
  Future<void> sigOut() async {
    await _firebaseAuth.signOut();
  }
}
