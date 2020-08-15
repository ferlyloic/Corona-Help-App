import 'package:coronahelpapp/main.dart';
import 'package:coronahelpapp/screens/auth/signin_view.dart';
import 'package:coronahelpapp/screens/auth/register_view.dart';
import 'package:flutter/material.dart';

class AuthenticateView extends StatefulWidget {
  static String titleString = 'Authentifizieren';

  @override
  _AuthenticateViewState createState() => _AuthenticateViewState();
}

class _AuthenticateViewState extends State<AuthenticateView> {

  bool isLoginView = true;
  /// toggle between login and register views.
  void toggleView(){
    setState(() {
      isLoginView = !isLoginView;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AuthenticateView.titleString,
          style: TextStyle(color: MyApp.getTitleColor(context)),
        ),
      ),
      body: Container(
        child: isLoginView ? SignInView(toggleView: toggleView) : RegisterView(toggleView: toggleView),
      ),
    );
  }
}
