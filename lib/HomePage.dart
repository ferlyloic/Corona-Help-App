import 'package:coronahelpapp/BottomNavigationBar.dart';
import 'package:coronahelpapp/CustomBarWidget.dart';
import 'package:coronahelpapp/main.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}
class _HomePageState extends State<HomePage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        CustomBarWidget(),
      ],)
    );
  }
}


