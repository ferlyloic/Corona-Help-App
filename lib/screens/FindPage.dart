import 'package:coronahelpapp/main.dart';
import 'package:coronahelpapp/models/service.dart';
import 'package:coronahelpapp/models/user.dart';
import 'package:coronahelpapp/models/user_role.dart';
import 'package:coronahelpapp/screens/auth/authenticate.dart';
import 'package:coronahelpapp/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FindPage extends StatefulWidget {
  static const String titleString = "Liste";

  @override
  State<StatefulWidget> createState() {
    return _FindPageState();
  }
}

class _FindPageState extends State<FindPage> {
  List<dynamic> _usersList = [];


  List<Service> _userServices;

  User _user;

  Future<void> _getData() async {
    if (_usersList != null)
      setState(() {
        fetchCategories();
      });
  }

  void fetchCategories() async {

    final String apiUrl = "https://randomuser.me/api/?results=${_userServices != null ? _userServices.length:'10'
    }&nat=de";
    print(apiUrl);
    var result = await http.get(apiUrl);
    setState(() {
      _usersList = json.decode(result.body)['results'];
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

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Widget _buildList() {
    _user = AuthService().getCurrentUser(context);
    _userServices = Service.all(context);
    if(_user != null) {
      print(_userServices);
      _userServices = _userServices
          .where((Service element) =>
      (_user.role == UserRole.HelpProvider
          ? element.helpProvider
          : element.helpReceiver) ==
          _user.userFromFirebase.uid)
          .toList();
      print(_userServices.length);
    }
    return (_user == null)
        ? AuthenticateView():_getServicesListWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          FindPage.titleString,
          style: TextStyle(color: MyApp.getTitleColor(context)),
        ),
      ),
      body: _buildList(),
    );
  }

  _getServicesListWidget() {

    print(_userServices.length);

    return _userServices != null
        ?
        RefreshIndicator(
      child: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: _usersList.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: MyApp.getModeColor(context),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            _usersList[index]['picture']['large'])),
                    title: Text(_name(_usersList[index])),
                    subtitle: Text(_location(_usersList[index])),
                    trailing: Text(_age(_usersList[index])),
                  )
                ],
              ),
            );
          }),
      onRefresh: _getData,
    )
    :  Container( child:  Text('Sie haben noch keine Einträge'),);
//    : Center(child: CircularProgressIndicator());
  }
}
