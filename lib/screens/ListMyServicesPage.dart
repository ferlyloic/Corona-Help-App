import 'package:coronahelpapp/main.dart';
import 'package:coronahelpapp/models/service.dart';
import 'package:coronahelpapp/models/user.dart';
import 'package:coronahelpapp/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      _userServices = Service.all(context);
      _userServices?.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      _userServices = _userServices
          ?.where((Service element) =>
              (element.helpProvider == _user.id) ||
              (element.helpReceiver == _user.id))
          ?.toList();
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

//  return the ListView of the service widgets
  _getServicesListWidget() {
    // if there is a authenticated user, show the list of all his/her services.
    return _userServices != null
        ? Container(
            child: ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: _userServices.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SingleServiceView(_userServices[index])));
                    },
                    child: Card(
                      color: _userServices[index]
                          .categoryObject(context)
                          .color(context),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              _userServices[index]
                                      .categoryObject(context)
                                      .name ??
                                  '',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
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
        : Center(
            child: Text(
              'Sie haben noch keine Einträge',
              style: TextStyle(color: MyApp.defaultPrimaryColor),
            ),
          );
//    : Center(child: CircularProgressIndicator());
  }
}
