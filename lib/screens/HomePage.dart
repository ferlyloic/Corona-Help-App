import 'package:coronahelpapp/main.dart';
import 'package:coronahelpapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final user = Provider.of<User>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            HomePage.titleString,
            style: TextStyle(color: MyApp.getTitleColor(context)),
          ),
        ),
        body: Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Stack(
              children: <Widget>[
                CustomBarWidget(),
                Container(
                  child: Text(user != null ? user.toString() : "no user logged in"),
                ),
              ],
            )));
  }

  @override
  void initState() {
    print("init HOME");
    super.initState();
//    checkLoginStatus();
  }
}
