import 'package:firebase_auth/firebase_auth.dart';

class User {
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
    return this.uid +
        ": " +
        this.firstName +
        " " +
        this.lastName +
        " " +
        this.birthDate.toString();
  }
}
