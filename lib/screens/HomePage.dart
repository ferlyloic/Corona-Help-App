import 'package:coronahelpapp/main.dart';
import 'package:coronahelpapp/models/service_category.dart';
import 'package:coronahelpapp/models/user.dart';
import 'package:coronahelpapp/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';

import 'CustomBarWidget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  static const String titleString = "Home";

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    print(ServiceCategory.all(context));
    final User user = AuthService().getCurrentUser(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            HomePage.titleString,
            style: TextStyle(color: MyApp.getTitleColor(context)),
          ),
        ),
        body: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(children: <Widget>[
//              CustomBarWidget(),
//              Container(
//                child:
//                    Text(user != null ? user.toString() : "no user logged in"),
//              ),
              MultiSelect(
                  autovalidate: false,
                  titleText: "Filtern",
                  validator: (value) {
                    if (value == null) {
                      return 'Please select one or more option(s)';
                    }
                    return null;
                  },
                  errorText: 'Please select one or more option(s)',
                  dataSource: ServiceCategory.all(context).map((e) {
                    return {'display':e.name, 'value':e};
                  }).toList(),
//                          [
//                            {
//                              "display": "Australia",
//                              "value": 1,
//                            },
//                            {
//                              "display": "Canada",
//                              "value": 2,
//                            },
//                            {
//                              "display": "India",
//                              "value": 3,
//                            },
//                            {
//                              "display": "United States",
//                              "value": 4,
//                            }
//                          ],
                  textField: 'display',
                  valueField: 'value',
                  filterable: true,
//                  required: true,
                  value: null,
                  onSaved: (value) {
                    print('The value is $value');
                  }
              ),
              SizedBox(height: 20.0),
            ])));
  }

  @override
  void initState() {
    print("init HOME");
    super.initState();
//    checkLoginStatus();
  }
}
