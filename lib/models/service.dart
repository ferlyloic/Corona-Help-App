
import 'package:coronahelpapp/models/default_model.dart';
import 'package:coronahelpapp/models/service_category.dart';
import 'package:coronahelpapp/models/service_status.dart';
import 'package:coronahelpapp/models/user.dart';

class Service extends DefaultModel{
  String id;
  User helpProvider;
  User helpReceiver;
  ServiceCategory category;
  ServiceStatus status;
  String description;
  DateTime createdAt;

  @override
  // TODO: implement collectionName
  String get collectionName => 'services';

  @override
  // TODO: implement data
  Map<String, dynamic> get data {
   return {
     'help_provider':this.helpProvider?.toString(),
     'help_receiver':this.helpReceiver?.toString(),
     'category':this.category?.name,
     'description':this.description,
     'status':this.status?.toString(),
   };
  }

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}
