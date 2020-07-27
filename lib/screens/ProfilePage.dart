import 'package:coronahelpapp/main.dart';
import 'package:coronahelpapp/models/user.dart';
import 'package:coronahelpapp/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../services/auth_service.dart';

class ProfilePage extends StatefulWidget {
  static const String titleString = "Profil";

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  SharedPreferences sharedPreferences;
  User _user;
  bool isUserConnected = false;

  Future<void> _getData() async {
    // TODO use this function or delete it.
    print("entering method detData");
  }

  @override
  void initState() {
    print("init profil");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     _user = AuthService().getCurrentUser(context);
     print(_user);
     isUserConnected = _user != null;
    print("isConnected :$isUserConnected");
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            ProfilePage.titleString,
            style: TextStyle(color: MyApp.getTitleColor(context)),
          ),
        ),
        body: _getLoginOrProfile());
  }

  _profileView() {
    print("entering method profileView");
    print("_users = ${_user}");
    return _user != null
        ? RefreshIndicator(
            onRefresh: _getData,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                // background image and bottom contents
                Column(
                  children: <Widget>[
                    Container(
                      height: 200.0,
//              color: Colors.orange,
                      decoration: BoxDecoration(
                        image: DecorationImage(
//                          image: NetworkImage(_user.imagePath),
                          // TODO: update the image when the user is logged in.
                          image: _user.getBackgroundImage(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
//                        color: Colors.white,
                        child: Center(
                          child: Stack(
                            children: <Widget>[
                              RaisedButton(
                                child: Text("Logout"),
                                onPressed: () {
                                  print("Logout pressed");
//                                  sharedPreferences.clear();
                                  AuthService().logout();
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                // Profile image
                Positioned(
                  top:
                      150.0, // (background container size) - (circle height / 2)
                  child: Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
//                          image: NetworkImage(_user.imagePath),
                          // TODO: update the image when the user is logged in.
                          image: _user.getProfileImage(),
                          fit: BoxFit.cover,
                        ),
                        color: MyApp.getModeColor(context)),
                  ),
                ),
              ],
            ),
          )
        : Center(child: CircularProgressIndicator());
  }

  Widget _getLoginOrProfile() {
    print(isUserConnected);
    return !isUserConnected ? LoginPage() : _profileView();
  }
}
