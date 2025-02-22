import 'package:coronahelpapp/main.dart';
import 'package:coronahelpapp/models/service.dart';
import 'package:coronahelpapp/models/service_category.dart';
import 'package:coronahelpapp/models/service_status.dart';
import 'package:coronahelpapp/models/user.dart';
import 'package:coronahelpapp/models/user_role.dart';
import 'package:coronahelpapp/screens/shared/loading.dart';
import 'package:coronahelpapp/services/auth_service.dart';
import 'package:coronahelpapp/services/validation_service.dart';
import 'package:flutter/material.dart';

class CreateServicePage extends StatefulWidget {
  CreateServicePage({Key key}) : super(key: key);
  static const String titleString = "Erstellen";

  @override
  State<StatefulWidget> createState() {
    return _CreateServicePageState();
  }
}

class _CreateServicePageState extends State<CreateServicePage> {
  final _formKey = GlobalKey<FormState>();
  ServiceCategory chosenCategory;
  String textOverCategories = 'Wähle eine Kategorie aus';
  final textInputController = TextEditingController();

  bool _onLoading = false;

  String _description;
  ServiceCategory _category;
  String _errorMessage;

  User user;

  @override
  Widget build(BuildContext context) {
    user = AuthService().getCurrentUser(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          user == null
              ? CreateServicePage.titleString
              : (user.role == UserRole.HelpProvider
                  ? "Hilfe anbieten"
                  : 'Hifle suchen'),
          style: TextStyle(color: MyApp.getTitleColor(context)),
        ),
      ),
      body: _getCreateServiceFormView(),
    );
  }

  _getErrorTextWidget() {
    return _errorMessage == null
        ? Container()
        : Stack(children: [
            Text(
              _errorMessage,
              style: TextStyle(color: Colors.red, fontSize: 14.0),
            ),
            SizedBox(height: 20)
          ]);
  }

  _getCreateServiceFormView() {
    return _onLoading
        ? Loading()
        : SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    Text(
                      'Formular ausfüllen',
                      style: TextStyle(
                          fontSize: 20, color: MyApp.defaultPrimaryColor),
                    ),
                    SizedBox(height: 20.0),
                    DropdownButtonFormField<ServiceCategory>(
                      validator: (value) =>
                          value == null ? 'field required' : null,
                      hint: Text(
                        'Kategorie auswählen',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      value: _category,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(
//                  color: Colors.deepPurple
                          ),
                      onChanged: (ServiceCategory newValue) {
                        setState(() {
                          _category = newValue;
                        });
                        print(_category);
                      },
                      items: ServiceCategory.all(context)
                          .map<DropdownMenuItem<ServiceCategory>>(
                              (ServiceCategory value) {
                        return DropdownMenuItem<ServiceCategory>(
                          value: value,
                          child: Text(
                            value.name,
                            style: TextStyle(
//                                color: MyApp.defaultPrimaryColor,
                              color: value.color(context),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                        controller: textInputController,
                        onChanged: (value) {
                          _description = value;
                        },
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        //Normal textInputField will be displayed
                        maxLines: 5,
                        // when user presses enter it will adapt to it
                        validator: (String arg) {
                          ValidationService val = ValidationService(arg);
                          val.minLength(15);
                          val.minWordCharacterNumber(1);
                          return val.errorResult();
                        },
                        decoration: InputDecoration(labelText: "Description")),
                    _getErrorTextWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                        color: MyApp.defaultPrimaryColor,
                        child: Text(
                          "Antrag speichern",
                          style: TextStyle(
                              color: MyApp.isDark(context)
                                  ? Colors.black
                                  : Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _onLoading = true;
                            });

                            print(_category);
                            print(_description);
//                              try{
                            Service service = Service();
                            service.category = _category.id;
                            if (user.role == UserRole.HelpProvider) {
                              service.helpProvider = user.id;
                            } else {
                              service.helpReceiver = user.id;
                            }
                            service.description = _description;
                            service.status = ServiceStatus.NotStarted;
                            service.create();
                            textInputController.clear();
                            print("Result: ${service}");
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text(
                                  'Success',
                                  style: TextStyle(color: Colors.green),
                                ),
                                content: Text(
                                    'die Serviceanfrage wurde erfolgreich erstellt. 😉'),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('schliessen'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                            setState(() {
                              _category = null;
                              _onLoading = false;
                            });
//                              } on /*PlatformException*/Exception catch ( e) {
//                                setState(() {
//                                  _onLoading = false;
//                                  _errorMessage = e.toString();
//                                  print(_errorMessage);
//                                });
//                              } catch ( e) {
//                                setState(() {
//                                  _onLoading = false;
//                                  _errorMessage = 'fails to register. pleas try again later.';
//                                });
//                                print(e.toString());
//                              }

                          } else {
                            if (_errorMessage != null)
                              setState(() => _errorMessage = null);
                            print("at least 1 field is not valid");
                          }
                        }),
                  ])),
            ),
          );
  }
}
