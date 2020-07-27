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

//  var user;
  final String apiUrl = "https://randomuser.me/api/?results=1";
  bool isUserConnected = false;

  Future<void> _getData() async {
    print("entering method detData");
//    if(sharedPreferences.getString("user")==null)
//      setState(()  {
//        fetchCategories();
//      });
  }

  @override
  void initState() {
    print("init profil");
    super.initState();
//    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
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
                          image: NetworkImage(_user.imagePath),
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
                                  sharedPreferences.clear();
                                  setState(() {
                                    isUserConnected = false;
                                    print(sharedPreferences.getString("user"));
                                  });
//                                sharedPreferences.commit();
//                                AuthService().logout();
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
                          image: NetworkImage(_user.imagePath),
                          fit: BoxFit.cover,
                        ),
                        color: Colors.green),
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

//  getCurrentUser() {
//    var current = AuthService().getUser();
//    print("user : $current");
//    setState(() {
//      _users = current;
//    });
//          return current;
//  }

}
