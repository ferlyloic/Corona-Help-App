import 'package:coronahelpapp/main.dart';
import 'package:coronahelpapp/models/user.dart';
import 'package:coronahelpapp/models/user_role.dart';
import 'package:coronahelpapp/screens/shared/loading.dart';
import 'package:coronahelpapp/services/auth_service.dart';
import 'package:coronahelpapp/services/validation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterView extends StatefulWidget {
  final Function toggleView;

  const RegisterView({Key key, this.toggleView}) : super(key: key);
  @override
  RegisterViewState createState() => RegisterViewState();
}

class RegisterViewState extends State<RegisterView> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  String _username;
  String _password;
  String _email;
  String _errorMessage;
  String _confirmPassword;

  bool _autoValidate = false;

  bool _onLoading = false;

  String _firstname;

  String _lastname;

  UserRole _userRole;


  @override
  Widget build(BuildContext context) {
    print("building RegisterView");
    return _onLoading
        ? Loading()
        :Scaffold(
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
                  _firstname = value;
//                  print(value);
                },
                onSaved: (value) {
                  _firstname = value;
//                  print(value);
                },
                keyboardType: TextInputType.text,
                validator: (String arg) {
                  ValidationService val = ValidationService(arg);
                  val.minLength(4);
                  val.hasNoWhiteSpaces();
                  return val.errorResult();
                },
                decoration: InputDecoration(labelText: "First name")),
            SizedBox(height: 20.0),
            TextFormField(
                onChanged: (value) {
                  _lastname = value;
//                  print(value);
                },
                onSaved: (value) {
                  _lastname = value;
//                  print(value);
                },
                keyboardType: TextInputType.text,
                validator: (String arg) {
                  ValidationService val = ValidationService(arg);
                  val.minLength(4);
                  val.hasNoWhiteSpaces();
                  return val.errorResult();
                },
                decoration: InputDecoration(labelText: "Last name")),
            SizedBox(height: 20.0),
                  DropdownButtonFormField<UserRole>(
                    validator: (value) => value == null ? 'field required' : null,
                    hint: Text(
                        'Rolle auswählen',
                      style: TextStyle(
                        color: MyApp.defaultPrimaryColor,
                      ),
                    ),
                    value: _userRole,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(
//                  color: Colors.deepPurple
                        ),
                    onChanged: (UserRole newValue) {
                      setState(() {
                        _userRole = newValue;
                      });
                      print(_userRole);
                    },
                    items: UserRole.values
                        .map<DropdownMenuItem<UserRole>>((UserRole value) {
                      return DropdownMenuItem<UserRole>(
                        value: value,
                        child: Text(value == UserRole.HelpProvider
                            ? 'Helfer(in)'
                            : 'Hilfesuchende(r)',
                          style: TextStyle(
                          color: MyApp.defaultPrimaryColor,
                        ),),
                      );
                    }).toList(),
                  ),
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
                  ValidationService val = ValidationService(arg);
                  val.minLength(4);
                  val.hasNoWhiteSpaces();
                  return val.errorResult();
                },
                decoration: InputDecoration(labelText: "User name")),
            TextFormField(
              onChanged: (value) {
                _email = value;
//                  print(value);
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: "Email Address"),
              validator: (String arg) {
                ValidationService val = ValidationService(arg);
                val.isEmail();
                return val.errorResult();
              },
            ),
            TextFormField(
                onChanged: (value) => _password = value,
                obscureText: true,
                decoration: InputDecoration(labelText: "Password"),
                validator: (String arg) {
                  ValidationService val = ValidationService(arg);
                  val.isStrongPassword();
                  if (val.errorResult() != null) return val.errorResult();
                  if(_password != _confirmPassword) return "the given passwords don't match.";
                  return null;
                  },),
            TextFormField(
              onChanged: (value) => _confirmPassword = value,
              obscureText: true,
              decoration: InputDecoration(labelText: "Confirm password"),
              validator: (String arg) {
                if(_password==null) return null;
                ValidationService val = ValidationService(arg);
                val.isStrongPassword();
                return val.errorResult();
              },
            ),
            SizedBox(height: 20.0),
            _getErrorTextWidget(),
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
                    setState(() {
                      _onLoading = true;
                    });
                    print(_email);
                    print(_password);
                    print(_username );
                    try{
                      User user = await _authService.registerWithEmailAndPassword(email: _email,password: _password);
                      user.firstName = _firstname;
                      user.lastName = _lastname;
                      user.username = _username;
                      user.role = _userRole;
                      print("Result: ${user}");
                    } on PlatformException catch ( e) {
                      setState(() {
                        _onLoading = false;
                        _errorMessage = e.message;
                        print(_errorMessage);
                      });
                    } catch ( e) {
                      setState(() {
                        _onLoading = false;
                        _errorMessage = 'fails to register. pleas try again later.';
                      });
                      print(e.toString());
                    }

                  }else{
                    if(_errorMessage != null) setState(() => _errorMessage = null);
                    print("at least 1 field is not valid");
                  }


                }),
            FlatButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      color: MyApp.defaultPrimaryColor
                  ),
                ),
                onPressed: () async {
                  print(" Registering canceled");
                  widget.toggleView();
                }),
          ],
        ),
      ),
    )));
  }

  _getErrorTextWidget() {
    return _errorMessage == null
        ? Container()
        : Stack(children: [Text(_errorMessage,style: TextStyle(color: Colors.red, fontSize: 14.0),), SizedBox(height: 20)]);
  }
}
