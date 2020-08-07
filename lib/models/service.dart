
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronahelpapp/models/default_model.dart';
import 'package:coronahelpapp/models/service_category.dart';
import 'package:coronahelpapp/models/service_status.dart';
import 'package:coronahelpapp/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Service extends DefaultModel {
  String id;
  String helpProvider;
  String helpReceiver;
  String category;
  ServiceStatus status;
  String description;
  DateTime createdAt;

  Service();
  @override
  // TODO: implement collectionName
  String get collectionName => 'services';

  @override
  // TODO: implement data
  Map<String, dynamic> get data {
    return {
      'help_provider':this.helpProvider?.toString(),
      'help_receiver':this.helpReceiver?.toString(),
      'category':this.category,
      'description':this.description,
      'status':this.status?.toString(),
      'created_at':this.createdAt,
    };
  }

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }

  Stream<List<Service>> get services {
    print('stream $collectionName');
    return collection.snapshots().map(_getAllServices);
  }

  List<Service> _getAllServices(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      var service = Service();
      service.id = doc.documentID;
      service.helpReceiver = doc.data['help_receiver'];
      service.category = doc.data['category'];
      service.description = doc.data['description'];
      service.createdAt = DateTime.tryParse(doc.data['created_at']);
      return service;
    }).toList();
  }

  static List<Service> all(BuildContext context) {
    var result = Provider.of<List<Service>>(context);
    result?.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return result;
  }
  @override
  String toString() {
    // TODO: implement toString
    return data.toString();
  }
}
