import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronahelpapp/models/default_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ServiceCategory extends DefaultModel {
  final String name;
  final String description;

  String id;

  ServiceCategory({this.id, this.name, this.description = ''});
  static List<ServiceCategory> all(BuildContext context){
    var result = Provider.of<List<ServiceCategory>>(context);
    print(result.length);
    result.sort((a, b) => a.name.compareTo(b.name));
    return result;
  }
  Stream<List<ServiceCategory>> get categories {
    return collection.snapshots().map(_getAllCategories);
  }
//  get id {
//    return this.name.toLowerCase().replaceAll(RegExp(r'\W'), '_').replaceAll('-','_');
//  }
  @override
  // TODO: implement collectionName
  String get collectionName => 'service_categories';

  @override
  // TODO: implement data
  Map<String, dynamic> get data =>
      {
        'name':this.name,
        'description':description,
      };

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }

  List<ServiceCategory> _getAllCategories(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return ServiceCategory(id: doc.documentID, name:doc.data['name'], description: doc.data['description']);
    }).toList();
  }
  @override
  create() {
    // TODO: do nothing.
  }
  @override
  String toString() {
    // TODO: implement toString
    return {
      'id': this.id,
      'name': this.name,
      'description': this.description,
    }.toString();
  }
}
