import 'package:coronahelpapp/screens/auth/login_page.dart';
import 'package:coronahelpapp/screens/auth/register_page.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool isLoginView = true;
  /// toggle between login and register views.
  void toggleView(){
    setState(() {
      isLoginView = !isLoginView;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isLoginView ? LoginPage(toggleView: toggleView) : RegisterView(toggleView: toggleView),
    );
  }
}
