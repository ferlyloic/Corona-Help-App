import 'dart:async';
import 'package:coronahelpapp/models/user.dart';
import 'package:coronahelpapp/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _currentUser;

  /// return User from firebase user object [firebaseUser].
  User _userFromFirebaseUser(FirebaseUser firebaseUser) {
    _currentUser = firebaseUser != null ? User(firebaseUser) : null;
    return _currentUser;
  }

  Future<User> anonymSign() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      print(result.toString());
      FirebaseUser firebaseUser = result.user;
      print(firebaseUser.uid);
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
  User getCurrentUser(BuildContext context) {
    return Provider.of<User>(context);
  }
  void logout() {
    _auth.signOut();
  }
//
//  // wrapping the firebase calls
//  Future createUser(
//      {String firstName,
//        String lastName,
//        String email,
//        String password}) async {}
//
  /// logs in the user with corresponding [email] and [password].
  Future<User> signInWithEmailAndPassword({String email, String password}) async {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      print(result.toString());
      FirebaseUser firebaseUser = result.user;
      print(firebaseUser.uid);
      return _userFromFirebaseUser(firebaseUser);
  }
  /// register the user with corresponding [email] and [password].
  Future<User> registerWithEmailAndPassword({String email, String password}) async {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print(result.toString());
      FirebaseUser firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
  }
//  /// delete the user with corresponding [email] and [password].
//  Future deleteUser(String email, String password) async {
//    try {
//      FirebaseUser user = await _auth.currentUser();
//      AuthCredential credentials =
//      EmailAuthProvider.getCredential(email: email, password: password);
//      print(user);
//      AuthResult result = await user.reauthenticateWithCredential(credentials);
//      await DatabaseService(uid: result.user.uid).deleteUser(); // called from database class
//      await result.user.delete();
//      return true;
//    } catch (e) {
//      print(e.toString());
//      return null;
//    }
//  }
  /// delete the current user in [context].
  Future deleteUser(BuildContext context) async {
    try {
    User user = AuthService().getCurrentUser(context);
      await DatabaseService(uid: user.userFromFirebase.uid).deleteUser(); // called from database class
      await user.userFromFirebase.delete();
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
