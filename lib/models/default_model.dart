import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronahelpapp/models/user.dart';

abstract class DefaultModel{
  CollectionReference collection;


  String get collectionName;
  String id;
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
    var currentData = data;
    currentData['created_at'] = DateTime.now().toString();
    print(currentData);
    print(this.id);
    if(id!=null)
      return await collection.document(id).setData(currentData, merge: true);
    return collection.add(currentData).then((value) {
      id = value.documentID;
    });
  }
Stream <QuerySnapshot> get dataFromFireStore {
    return collection.snapshots();
}

}