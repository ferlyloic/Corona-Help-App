import 'dart:math';

import 'package:coronahelpapp/main.dart';
import 'package:coronahelpapp/models/service_category.dart';
import 'package:coronahelpapp/models/user.dart';
import 'package:coronahelpapp/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
             _getFilter(),
              SizedBox(height: 20.0),
              Expanded(child: _buildList()),
            ])));
  }






  List<dynamic> _users = [];
  final String apiUrl = "https://randomuser.me/api/?results=100&nat=de";

  Future<void> _getData() async {
    if (_users != null)
      setState(() {
        fetchCategories();
      });
  }

  void fetchCategories() async {
    print(apiUrl);
    var result = await http.get(apiUrl);
    setState(() {
      _users = json.decode(result.body)['results'];
    });
  }

  String _name(dynamic user) {
    return user['name']['title'] +
        " " +
        user['name']['first'] +
        " " +
        user['name']['last'];
  }

  String _location(dynamic user) {
    return user['location']['city'];
  }

  String _age(Map<dynamic, dynamic> user) {
    return "Age: " + user['dob']['age'].toString();
  }
  Widget _buildList() {
    return _users?.length != 0
        ? RefreshIndicator(
      child: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: _users.length,
          itemBuilder: (BuildContext context, int index) {
            ServiceCategory category = _categorie(context);
            return Card(
//              color: MyApp.getModeColor(context),
              color: category.color(context),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            _users[index]['picture']['large'])),
                    title: Text(_name(_users[index])),
                    subtitle: Text(category.name),
                    trailing: Text(_location(_users[index])),
                  )
                ],
              ),
            );
          }),
      onRefresh: _getData,
    )
        : Center(child: CircularProgressIndicator());
  }
  @override
  void initState() {
    print("init HOME");
    super.initState();
    fetchCategories();
//    checkLoginStatus();
  }

  ServiceCategory _categorie(BuildContext context) {
    var all = ServiceCategory.all(context);
    return all.elementAt(0 + Random().nextInt(all.length));
  }

  _getFilter() {
    return MultiSelect(

        autovalidate: false,
        titleText: "Filter-Optionen auswählen",
        validator: (value) {
          if (value == null) {
            return 'Please select one or more option(s)';
          }
          return null;
        },
        errorText: 'Please select one or more option(s)',
        dataSource: ServiceCategory.all(context)?.map((e) {
          return {'display': e.name, 'value': e};
        })?.toList(),
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
        hintText: 'Keine Option ausgewählt',
//                  required: true,
        value: null,
        onSaved: (value) {
          print('The value is $value');
        });
  }
}
