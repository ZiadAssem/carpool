import 'package:carpool/firebase/sign-up-failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Authentication._();
  static final Authentication _instance = Authentication._();
  static Authentication get instance => _instance;

  isUserSignedIn() {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  Future<String?> createUserWithEmailAndPassword(
      String emailAddress, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return null; // Return null for success
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      return ex.message; // Return the error message for failure
    } catch (e) {
      return e.toString(); // Return a string representation of other exceptions
    }
  }

  signInWithEmailAndPassword(emailAddress, password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  getCurrentUser(context) async {
    final User? user =  _auth.currentUser;
    final uid = user!.uid;
    return uid;
    }
}
