import 'package:coronahelpapp/main.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  static const String titleString = "Profil";
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}
class _ProfilePageState extends State<ProfilePage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(ProfilePage.titleString,
          style:  TextStyle(
            color: MyApp.getTitleColor(context)
        ),
        ),
      ),
    );
  }
}

