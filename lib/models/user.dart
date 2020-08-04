import 'package:coronahelpapp/models/default_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class User extends DefaultModel{
  String username;
  String firstName;
  String lastName;
  DateTime birthDate;
  String imagePath;
  final String uid;

  User(this.uid);

  String fullName() {
    return this.firstName + " " + this.lastName;
  }

  int age() {
    return DateTime.now().year - birthDate.year;
  }

  @override
  String toString() {
    // TODO: update toString
    return this.uid
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
}
