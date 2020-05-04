import 'package:coronahelpapp/main.dart';
import 'package:flutter/material.dart';

class FindPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _FindPageState();
  }
}
class _FindPageState extends State<FindPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Suchen", style:  TextStyle(color: MyApp.getModeInvertedColor(context)),),
      ),
    );
  }
}

