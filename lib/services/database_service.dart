import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  /// user collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('users');
  final CollectionReference serviceCategoriesCollection =
      Firestore.instance.collection('service_categories');
  final CollectionReference servicesCollection =
      Firestore.instance.collection('services');
  final CollectionReference serviceStatusesCollection =
      Firestore.instance.collection('service_statuses');
  final String uid;

  DatabaseService({this.uid});

  Future updateUserData() async {
    return await userCollection.document(uid).delete();
  }

  Future deleteUser() {
    return userCollection.document(uid).delete();
  }
}
