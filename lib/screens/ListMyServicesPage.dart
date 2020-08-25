import 'package:coronahelpapp/main.dart';
import 'package:coronahelpapp/models/service.dart';
import 'package:coronahelpapp/models/service_category.dart';
import 'package:coronahelpapp/models/user.dart';
import 'package:coronahelpapp/models/user_role.dart';
import 'package:coronahelpapp/screens/auth/authenticate.dart';
import 'package:coronahelpapp/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'SingleServiceView.dart';

class ListMyServicesPage extends StatefulWidget {
  static const String titleString = "Meine Liste";

  @override
  State<StatefulWidget> createState() {
    return _ListMyServicesPageState();
  }
}

class _ListMyServicesPageState extends State<ListMyServicesPage> {
  List<dynamic> _usersList = [];

  List<Service> _userServices;

  User _user;

  Widget _buildList() {
    _user = AuthService().getCurrentUser(context);
    if (_user != null) {
      List<User> temp = [];
//      print(_userServices);
//      for(Service s in _userServices){
//        print(s.helpReceiver);
//      }
      _userServices = Service.all(context);
      _userServices?.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      _userServices = _userServices
          ?.where((Service element) =>
              (element.helpProvider == _user.id) ||
              (element.helpReceiver == _user.id))
          ?.toList();
//      print(_userServices?.length);
    }
    return _getServicesListWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          ListMyServicesPage.titleString,
          style: TextStyle(color: MyApp.getTitleColor(context)),
        ),
      ),
      body: _buildList(),
    );
  }

  _getServicesListWidget() {
//    print(_userServices?.length);

    return _userServices != null
        ? RefreshIndicator(
            child: ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: _userServices.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SingleServiceView(_userServices[index])
                          )
                      );
                    },
                    child: Card(
//              color: MyApp.getModeColor(context),
                      color: _userServices[index].categoryObject(context).color(context),
                      child: Column(
                        children: <Widget>[
                          ListTile(
//                    leading: CircleAvatar(
//                        radius: 30,
//                        backgroundImage: AssetImage('assets/default_user.png')),
                            title: Text(
                               _userServices[index].categoryObject(context).name ?? '',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
//                    subtitle: Text(_userServices[index].id),
                            trailing: Text(
                              _userServices[index].getFormattedCreatedAt,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            child: Column(children: [
                              Text(
                                _userServices[index].description,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
//                        Center(
//                          child: SingleChildScrollView(
//                            child: HtmlView(
//                              data:
//                              """<p>Lorem ipsum sollicitudin velit leo proin vivamus augue dictumst,
//                              litora commodo netus ut amet auctor eu.</p>\r<p>Habitasse sagittis curabitur
//                              ligula non convallis scelerisque, purus tristique sed aliquam enim,
//                              phasellus ut integer lorem posuere.</p>\r<p>Consequat quis mollis vulputate curabitur primis,
//                              leo platea fusce neque primis, turpis sociosqu hendrerit gravida.</p>\r""",
//                              onLaunchFail: (url) { // optional, type Function
//                                print("launch $url failed");
//                              },
//                              scrollable: false, //false to use MarksownBody and true to use Marksown
//                            ),
//                          ),
//                        ),
                            ]),
                            padding: EdgeInsets.fromLTRB(20, 0, 10, 10),
                            alignment: Alignment.bottomLeft,
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        : Container(
            child: Text('Sie haben noch keine Einträge'),
          );
//    : Center(child: CircularProgressIndicator());
  }
}
