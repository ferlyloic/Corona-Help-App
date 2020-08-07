import 'package:coronahelpapp/main.dart';
import 'package:coronahelpapp/models/service.dart';
import 'package:coronahelpapp/models/service_category.dart';
import 'package:coronahelpapp/models/service_status.dart';
import 'package:coronahelpapp/models/user.dart';
import 'package:coronahelpapp/models/user_role.dart';
import 'package:coronahelpapp/screens/offer/categories_list_view.dart';
import 'package:coronahelpapp/screens/offer/create_offer_view.dart';
import 'package:coronahelpapp/screens/shared/loading.dart';
import 'package:coronahelpapp/services/auth_service.dart';
import 'package:coronahelpapp/services/validation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';

class OfferPage extends StatefulWidget {
  OfferPage({Key key}) : super(key: key);
  static const String titleString = "Beantragen";

  @override
  State<StatefulWidget> createState() {
    return _OfferPageState();
  }
}

class _OfferPageState extends State<OfferPage> {
  final _formKey = GlobalKey<FormState>();
  ServiceCategory chosenCategory;
  String textOverCategories = 'Wähle eine Kategorie aus';

  bool _onLoading = false;

  String _description;
  ServiceCategory _category;
  String _errorMessage;
  @override
  Widget build(BuildContext context) {

    User user = AuthService().getCurrentUser(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          user == null ? OfferPage.titleString : (user.role == UserRole.HelpProvider ? "Hilfe anbieten" :'Hifle suchen'),
          style: TextStyle(color: MyApp.getTitleColor(context)),
        ),
      ),
      body: _onLoading
          ? Loading()
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Form(
                    key: _formKey,
                    child: Column(children: <Widget>[Text(
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
                                color: MyApp.defaultPrimaryColor,
                              ),

                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 20.0),

                      TextFormField(
                          onChanged: (value) {
                            _description = value;
                          },
                          keyboardType: TextInputType.multiline,
                          minLines: 1,//Normal textInputField will be displayed
                          maxLines: 5,// when user presses enter it will adapt to it
                          validator: (String arg) {
                            ValidationService val = ValidationService(arg);
                            val.minLength(15);
                            val.minWordCharacterNumber(1);
//                  val.hasNoWhiteSpaces();
                            return val.errorResult();
                          },
                          decoration: InputDecoration(labelText: "Description")),
                      _getErrorTextWidget(),
                      SizedBox(height: 20,),
                      RaisedButton(
                          color: MyApp.defaultPrimaryColor,
                          child: Text(
                            "Antrag speichern",
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

                              print(_category);
                              print(_description);
//                              try{
                                Service service = Service();
                                service.category = _category;
                                if(user.role == UserRole.HelpProvider) {
                                  service.helpProvider = user;
                                }else{
                                  service.helpReceiver = user;
                                }
                                service.description = _description;
                                service.status = ServiceStatus.NotStarted;
                                service.create();
                                print("Result: ${service}");
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

                            }else{
                              if(_errorMessage != null) setState(() => _errorMessage = null);
                              print("at least 1 field is not valid");
                            }

                          }),

                    ])),
              ),
            ),
    );
  }
  _getErrorTextWidget() {
    return _errorMessage == null
        ? Container()
        : Stack(children: [Text(_errorMessage,style: TextStyle(color: Colors.red, fontSize: 14.0),), SizedBox(height: 20)]);
  }
  setChosenCategory(ServiceCategory category) {
    chosenCategory = category;
    setState(() {
      this.textOverCategories = category == null? 'Wähle eine Kategorie aus': "Kategory ${category.name} ausgewählt.";
    });
//    // flutter defined function
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        // return object of type Dialog
//        return AlertDialog(
//          title:  Text("Kategory $chosenCategoryIndex ausgewählt."),
//          content: Text("Alert Dialog body"),
//          actions: <Widget>[
//            // usually buttons at the bottom of the dialog
//            new FlatButton(
//              child: new Text("Close"),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
//        );
//      },
//    );
  }
}

