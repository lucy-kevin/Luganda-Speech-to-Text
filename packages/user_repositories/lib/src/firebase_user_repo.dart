import 'dart:developer'; // Import the dart:developer library for logging

import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/src/models/user.dart';
import 'package:user_repository/src/user_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUserRepo implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final userCollection = FirebaseFirestore.instance.collection('users');

  FirebaseUserRepo({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser;
    });
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      log('Error signing in: $e'); // Log the error message
      rethrow;
    }
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: myUser.email,
        password: password,
      );

      myUser = myUser.copyWith(
        userId: user.user!.uid,
      );

      return myUser;
    } catch (e) {
      log('Error signing up: $e'); // Log the error message
      rethrow;
    }
  }

  @override
  Future<void> setUserData(MyUser myUser) async {
    try {
      await userCollection.doc(myUser.userId).set(myUser.toEntity().toDocument());
    } catch (e) {
      log('Error setting user data: $e'); // Log the error message
      rethrow;
    }
  }
  @override
  Future<void> logOut() async{
    await _firebaseAuth.signOut();
  }
}
