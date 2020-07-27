import 'package:flutter/material.dart';

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
    return Scaffold(
        body: Stack(
      children: <Widget>[
        CustomBarWidget(),
      ],
    ));
  }
}
