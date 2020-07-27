import 'dart:async';
import 'package:coronahelpapp/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _currentUser;

  /// return User from firebase user object [firebaseUser].
  User _userFromFirebaseUser(FirebaseUser firebaseUser) {
    _currentUser = firebaseUser != null ? User(firebaseUser.uid) : null;
  }

  Future<User> anonymSign() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      print(result.toString());
      FirebaseUser firebaseUser = result.user;

      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  /// stream user data from firebase into the current user.
  Stream<User> get user {
    return _auth.onAuthStateChanged
//        .map((FirebaseUser firebaseUser) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

//
//  AuthService() {
//    print("new instance of AuthService");
//  }
//
  getUser() {
    return _currentUser;
  }

//
//  // wrappinhg the firebase calls
//  Future logout() {
//    _currentUser = null;
//    notifyListeners();
//    return _currentUser;
//  }
//
//  // wrapping the firebase calls
//  Future createUser(
//      {String firstName,
//        String lastName,
//        String email,
//        String password}) async {}
//
//  // logs in the user if password matches
  Future loginUser({String email, String password}) {
//    TODO: implement the login logic.
  }
}
