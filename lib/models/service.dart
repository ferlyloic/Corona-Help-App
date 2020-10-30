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
  ServiceStatus status = ServiceStatus.NotStarted;
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
      'help_provider': this.helpProvider?.toString(),
      'help_receiver': this.helpReceiver?.toString(),
      'category': this.category,
      'description': this.description,
      'status': this.status?.toString(),
      'created_at': this.createdAt,
    };
  }

  get getFormattedCreatedAt {
    var now = DateTime.now();
//    print('now: ${now.day - 1}');
    var difference = now.difference(this.createdAt);
//    print('created_at: ${this.createdAt.day}');
//    print(difference.inHours);
    if (difference.inDays > 0) {
//      return 'Seit '+difference.inDays.toString() + ' Tage.';
      return 'Am ' +
          this.createdAt.day.toString() +
          '.' +
          this.createdAt.month.toString() +
          '.' +
          this.createdAt.year.toString();
    }
    if (now.day - 1 == this.createdAt.day) {
      return 'Gestern um ' +
          this.createdAt.hour.toString() +
          ':' +
          this.createdAt.minute.toString() +
          '.';
    }
//    print('created_at: ${this.createdAt.add(Duration(hours: 1))}');
    return 'Heute um ' +
        this.createdAt.hour.toString() +
        ':' +
        createdAt.minute.toString() +
        '.';
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
      service.helpProvider = doc.data['help_provider'];
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

  ServiceCategory categoryObject(BuildContext context) {
    return ServiceCategory.find(this.category, context);
  }
}
