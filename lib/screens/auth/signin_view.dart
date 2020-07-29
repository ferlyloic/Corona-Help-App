import 'package:coronahelpapp/main.dart';
import 'package:coronahelpapp/models/user.dart';
import 'package:coronahelpapp/services/auth_service.dart';
import 'package:coronahelpapp/services/validation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignInView extends StatefulWidget {
  final Function toggleView;

  const SignInView({Key key, this.toggleView}) : super(key: key);
  @override
  SignInViewState createState() => SignInViewState();
}

class SignInViewState extends State<SignInView> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  String _password;
  String _email;

  String _errorMessage;

  @override
  Widget build(BuildContext context) {
    print("entering method loginView");
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Text(
              'Login Information',
              style: TextStyle(fontSize: 20, color: MyApp.defaultPrimaryColor),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              validator: (arg){
                ValidationService val = ValidationService(arg);
                val.isEmail();
                return val.errorResult();
              },
              onChanged: (value)  {
                _email = value;
                print(value);
              },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "Email Address")),
            TextFormField(
              validator: (arg) {
                ValidationService val = ValidationService(arg);
                val.isNotNull();
                print(val.errorResult());
                return val.errorResult();
              },
                onChanged: (value) => _password = value,
                obscureText: true,
                decoration: InputDecoration(labelText: "Password")),
            SizedBox(height: 20,),
            _getErrorTextWidget(),
            RaisedButton(
                color: MyApp.defaultPrimaryColor,
                child: Text(
                  "Login",
                  style: TextStyle(
                      color:
                          MyApp.isDark(context) ? Colors.black : Colors.white),
                ),
                onPressed: () async {
                  print("login pressed");   if(_formKey.currentState.validate()) {
                    print(_email);
                    print(_password);
                    try{
                      User user = await _authService.signInWithEmailAndPassword(email: _email,password: _password);
                      print("Result: ${user.uid}");
                    } on PlatformException catch ( e) {
                      setState(() {
                        _errorMessage = e.message;
                        print(_errorMessage);
                      });
                    } catch ( e) {
                      _errorMessage = 'fails to register. pleas try again later.';
                      print(e.toString());
                    }

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
            FlatButton(
                child: Text(
                  "Register",
                  style: TextStyle(
                      color: MyApp.defaultPrimaryColor
                  ),
                ),
                onPressed: () async {
                  print("load RegisterView");
                  widget.toggleView();
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => RegisterView()),
//                  );
                }),
          ],
        ),
      ),
    );
  }
  _getErrorTextWidget() {
    return _errorMessage == null
        ? Container()
        : Stack(children: [Text(_errorMessage,style: TextStyle(color: Colors.red, fontSize: 14.0),), SizedBox(height: 20)]);
  }
}
