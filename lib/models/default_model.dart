import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DefaultModel{
  CollectionReference collection;


  String get collectionName;
  String get id;
DefaultModel(){
  collection = Firestore.instance.collection(collectionName);
}
  Map<String, dynamic> get data;



  Map<String,dynamic > toMap();
  bool save(){
    throw UnimplementedError();
  }
//  Future updateUserData() async {
//    return await collection.document(id).updateData(data);
//  }
  create() async {
//    Map<String, dynamic> dataWithCreatedDateTine = {'crated_at': DateTime.now()};
    data['created_at'] = DateTime.now().toString();
    print(data);
    return await collection.document(id).setData(data, merge: true);
  }
Stream <QuerySnapshot> get dataFromFireStore {
    return collection.snapshots();
}

}