import 'package:coronahelpapp/main.dart';
import 'package:coronahelpapp/services/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  @override
  RegisterViewState createState() => RegisterViewState();
}

class RegisterViewState extends State<RegisterView> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  String _username;
  String _password;
  String _email;

  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    print("building LoginView");
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      padding: EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Text(
              'Register Information',
              style: TextStyle(fontSize: 20, color: MyApp.defaultPrimaryColor),
            ),
            SizedBox(height: 20.0),
            TextFormField(
                onChanged: (value) {
                  _username = value;
//                  print(value);
                },
                onSaved: (value) {
                  _username = value;
//                  print(value);
                },
                keyboardType: TextInputType.text,
                validator: (String arg) {
                  if (arg.length < 4)
                    return 'Name must be more than 4 charater';
                  else
                    return null;
                },
                decoration: InputDecoration(labelText: "User name")),
            TextFormField(
                onChanged: (value) {
                  _email = value;
//                  print(value);
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "Email Address")),
            TextFormField(
                onChanged: (value) => _password = value,
                obscureText: true,
                decoration: InputDecoration(labelText: "Password")),
            TextFormField(
                onChanged: (value) => _password = value,
                obscureText: true,
                decoration: InputDecoration(labelText: "Repeat password")),
            SizedBox(height: 20.0),
            RaisedButton(
                color: MyApp.defaultPrimaryColor,
                child: Text(
                  "Register",
                  style: TextStyle(
                      color:
                          MyApp.isDark(context) ? Colors.black : Colors.white),
                ),
                onPressed: () async {
                  print("register pressed");
                  if(_formKey.currentState.validate()) {
                    print(_email);
                    print(_password);
                    print(_username );
                  }else{
                    print("fields are not valid");
                  }

//                  User user = await _authService.anonymSign();
//                  if (user != null) {
//                    print("Result: ${user.uid}");
//                  } else {
////                    TODO: implement an error response here.
//                    print("Result: no user returned");
//                  }
                }),
          ],
        ),
      ),
    )));
  }
}
