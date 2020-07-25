import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  static var _currentUser;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<FirebaseUser> anonymSign() async {
    try{
      AuthResult result = await _auth.signInAnonymously();
      print(result.toString());
      FirebaseUser user = result.user;
      return user;
    } catch(e) {
      print(e.toString());
      return null;
    }
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
class User{
  String username;
  String firstName;
  String lastName;
  DateTime birthDate;
  String imagePath;
  User(this.username, this.firstName, this.lastName,this.birthDate, this.imagePath);
  String fullName() {
    return this.firstName + " " + this.lastName;
  }
  int age(){
    return DateTime.now().year - birthDate.year;
  }
  @override
  String toString() {
    // TODO: implement toString
    return this.firstName + " " + this.lastName + " " + this.birthDate.toString() ;
  }
}