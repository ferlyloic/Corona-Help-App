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
    currentData['created_at'] = DateTime.now()
        .add(Duration(hours: 2)) // because of the timezone.
        .toString();
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
  Future<bool> delete() async {
    bool result = false;
    await collection.document(this.id).delete().then((value) => result = true)
        .catchError(
            (error) {
              print("Error removing document [${this.id}]: "+error);
              result = false;
            });
    return result;
  }

}