import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronahelpapp/main.dart';
import 'package:coronahelpapp/models/user.dart';
import 'package:coronahelpapp/screens/auth/authenticate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:coronahelpapp/services/auth_service.dart';
import 'package:coronahelpapp/screens/auth/signin_view.dart';

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
//     print(_user?.data);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          ProfilePage.titleString,
          style: TextStyle(color: MyApp.getTitleColor(context)),
        ),
      ),
      body: _getProfileView(),
    );
  }

  _profileView() {
//    print("entering method profileView");
//    print("_users = ${_user}");
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
                          child: ListView(
                            children: <Widget>[
                              SizedBox(
                                height: 50,
                              ),
                              Table(
                                children: [
                                  TableRow(children: [
                                    Text(
                                      "Vorname:",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: MyApp.isDark(context)
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    Text(
                                      _user.firstName == null
                                          ? 'N/A'
                                          : _user.firstName,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
//                                          fontWeight: FontWeight.bold,
                                          color: MyApp.isDark(context)
                                              ? Colors.white
                                              : Colors.black45),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Text(
                                      "Nachname:",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: MyApp.isDark(context)
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    Text(
                                      _user.lastName == null
                                          ? 'N/A'
                                          : _user.lastName,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
//                                          fontWeight: FontWeight.bold,
                                          color: MyApp.isDark(context)
                                              ? Colors.white
                                              : Colors.black45),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Text(
                                      "User name:",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: MyApp.isDark(context)
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    Text(
                                      _user.username == null
                                          ? 'N/A'
                                          : _user.username,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
//                                          fontWeight: FontWeight.bold,
                                          color: MyApp.isDark(context)
                                              ? Colors.white
                                              : Colors.black45),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Text(
                                      "Email:",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: MyApp.isDark(context)
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    Text(
                                      _user.userFromFirebase.email,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
//                                          fontWeight: FontWeight.bold,
                                          color: MyApp.isDark(context)
                                              ? Colors.white
                                              : Colors.black45),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Text(
                                      "Role:",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: MyApp.isDark(context)
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    Text(
                                      _user.role == null
                                          ? 'N/A'
                                          : _user.getRole(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
//                                          fontWeight: FontWeight.bold,
                                          color: MyApp.isDark(context)
                                              ? Colors.white
                                              : Colors.black45),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Text(
                                      "Location:",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: MyApp.isDark(context)
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    Text(
                                      _user.location == null
                                          ? 'N/A'
                                          : _user.location.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
//                                          fontWeight: FontWeight.bold,
                                          color: MyApp.isDark(context)
                                              ? Colors.white
                                              : Colors.black45),
                                    ),
                                  ]),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    "Beschreibung",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: MyApp.isDark(context)
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                  Text(
                                    _user.description,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
//                                      fontWeight: FontWeight.bold,
                                        color: MyApp.isDark(context)
                                            ? Colors.white
                                            : Colors.black45),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              RaisedButton(
                                color: MyApp.defaultPrimaryColor,
                                child: Text(
                                  "Abmelden",
                                  style: TextStyle(
                                      color: MyApp.isDark(context)
                                          ? Colors.black
                                          : Colors.white),
                                ),
                                onPressed: () {
                                  print("Logout pressed");
//                                  sharedPreferences.clear();
                                  AuthService().logout();
                                },
                              ),
                              RaisedButton(
                                color: Colors.blue,
                                child: Text(
                                  "Bearbeiten",
                                  style: TextStyle(
                                      color: MyApp.isDark(context)
                                          ? Colors.black
                                          : Colors.white),
                                ),
                                onPressed: () {
                                  print("update pressed");
//                                  sharedPreferences.clear();
                                  AuthService().logout();
                                },
                              ),
                              RaisedButton(
                                color: Colors.red,
                                child: Text(
                                  "Konto entfernen",
                                  style: TextStyle(
                                      color: MyApp.isDark(context)
                                          ? Colors.black
                                          : Colors.white),
                                ),
                                onPressed: () {
                                  print("delete pressed");
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

  Widget _getProfileView() {
    return _profileView();
  }
}
