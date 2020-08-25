import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronahelpapp/models/user.dart';
import 'package:coronahelpapp/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _currentUser;

  Future<User> anonymSign() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      print(result.toString());
      FirebaseUser firebaseUser = result.user;
      print(firebaseUser.uid);
      return User(userFromFirebase: firebaseUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//
//  AuthService() {
//    print("new instance of AuthService");
//  }
//
  User getCurrentUser(BuildContext context) {
    User user = Provider.of<User>(context);
    user?.loadDataFromFireStore(context);
    return user;
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
  Future<User> signInWithEmailAndPassword(
      {String email, String password}) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    print(result.toString());
    FirebaseUser firebaseUser = result.user;
//      print(firebaseUser.uid);
    return User(userFromFirebase: firebaseUser);
  }

  /// register the user with corresponding [email] and [password].
  Future<User> registerWithEmailAndPassword(
      {String email, String password}) async {
    AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    print(result.toString());
    FirebaseUser firebaseUser = result.user;
    return User(userFromFirebase: firebaseUser);
  }

  /// logout the current user.
  void logout() {
    _auth.signOut();
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
      await DatabaseService(uid: user.userFromFirebase.uid)
          .deleteUser(); // called from database class
      await user.userFromFirebase.delete();
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
