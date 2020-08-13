import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronahelpapp/models/default_model.dart';
import 'package:coronahelpapp/models/location.dart';
import 'package:coronahelpapp/models/user_role.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class User extends DefaultModel{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String username;
  String firstName;
  String lastName;
  DateTime birthDate;
  String imagePath;
  final FirebaseUser userFromFirebase;
  String description = 'no description.';
  UserRole role;
  LocationInfo location = LocationInfo();
  String email;

  User({this.userFromFirebase}){
//    this.setData(data);
  }
  /// stream user data from firebase into the current user.
  Stream<User> get user {
    Stream<User> userStream = _auth.onAuthStateChanged.map(_userFromFirebaseUser);
    return userStream;
  }
  /// return User from firebase user object [firebaseUser].
  User _userFromFirebaseUser(FirebaseUser firebaseUser)  {
return firebaseUser != null ? User(userFromFirebase: firebaseUser) : null;
  }

  String fullName() {
    return this.firstName + " " + this.lastName;
  }

  int age() {
    return DateTime.now().year - birthDate.year;
  }
  String getRole() {
    return this.role == UserRole.HelpProvider
        ? 'Helfer(in)'
        : (this.role == UserRole.HelpReceiver ? 'Hilfesuchende(r)' : null);
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

  @override
  // TODO: implement id
  get id {
    return this.userFromFirebase.email;
  }

  @override
  // TODO: implement data
  Map<String, dynamic> get data{
    return {
      'first_name': this.firstName,
      'last_name':this.lastName,
      'user_role':this.role.toString(),
      'location':this.location.toJson(),
      'username': this.username,
      'email': this.email,
    };
  }

  void setData(Map<String, dynamic> data) {
    print(data['user_role']);
    this.firstName = data['first_name'];
    this.lastName = data['last_name'];
    this.role = data['user_role'] == UserRole.HelpProvider.toString()
        ? UserRole.HelpProvider
        : (data['user_role'] == UserRole.HelpReceiver.toString()
            ? UserRole.HelpReceiver
            : null);
    this.location.fromJson(data['location']);
    this.username = data['username'];
    this.email = data['email'];
  }
  void loadDataFromFireStore(BuildContext context)  {
    final userData = Provider.of<QuerySnapshot>(context);
    if (userData != null) {
      for (var v in userData.documents) {
        if (this.id == v.documentID) {
          this.setData(v.data);
        }
        print(v.documentID);
      }
    }
  }
  Stream<List<User>> get users {
    return collection.snapshots().map(_getUsersList);
  }
  List<User> _getUsersList(QuerySnapshot snapshot){
    print('Snapshot');
    return snapshot.documents.map((doc) => User().setData(doc.data)).toList();
  }
}
