import 'package:coronahelpapp/models/default_model.dart';
import 'package:coronahelpapp/models/location.dart';
import 'package:coronahelpapp/models/user_role.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class User extends DefaultModel{

  String username = 'N/A';
  String firstName = 'N/A';
  String lastName = 'N/A';
  DateTime birthDate;
  String imagePath;
  final FirebaseUser userFromFirebase;
  String description = 'no description.';
  UserRole role;
  Location location = Location();

  User(this.userFromFirebase);

  String fullName() {
    return this.firstName + " " + this.lastName;
  }

  int age() {
    return DateTime.now().year - birthDate.year;
  }

  @override
  String toString() {
    // TODO: update toString
    return this.userFromFirebase?.uid
//        + ": " +
//        this.firstName
//        + " " +
//        this.lastName
//        + " " +
//        this.birthDate.toString()
    ;
  }

  getProfileImage() {
    return AssetImage("assets/default_user.png");
  }

  getBackgroundImage() {
    return AssetImage("assets/default.png");
  }

  @override
  Map<String,dynamic > toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }

  @override

  String get collectionName => 'users';
}
