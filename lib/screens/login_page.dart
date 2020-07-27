
import 'package:coronahelpapp/main.dart';
import 'package:coronahelpapp/models/user.dart';
import 'package:coronahelpapp/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  @override
  LoginPageState createState() => LoginPageState();
}
class LoginPageState extends State<LoginPage>{
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  String _password;
  String _email;
  @override
  Widget build(BuildContext context) {
    print("entering method loginView");
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Text(
              'Login Information',
              style:
              TextStyle(fontSize: 20, color: MyApp.defaultPrimaryColor),
            ),
            SizedBox(height: 20.0),
            TextFormField(
                onSaved: (value) => _email = value,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "Email Address")),
            TextFormField(
                onSaved: (value) => _password = value,
                obscureText: true,
                decoration: InputDecoration(labelText: "Password")),
            RaisedButton(
                color: MyApp.defaultPrimaryColor,
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: MyApp.isDark(context)
                          ? Colors.black
                          : Colors.white),
                ),
                onPressed: () async {
                  print("login pressed");
                  User user = await _authService.anonymSign();
                  if(user != null) {
                    print("Result: ${user.uid}");
                  }else{
//                    TODO: implement an error response here.
                  }
                }
            ),
          ],
        ),
      ),
    );
  }
}