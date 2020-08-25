import 'package:coronahelpapp/main.dart';
import 'package:coronahelpapp/models/service.dart';
import 'package:coronahelpapp/models/service_category.dart';
import 'package:coronahelpapp/models/user.dart';
import 'package:coronahelpapp/services/auth_service.dart';
import 'package:flutter/material.dart';

class SingleServiceView extends StatefulWidget {
  Service _service;
  SingleServiceView(this._service);
  @override
  _SingleServiceViewState createState() => _SingleServiceViewState();
}
class _SingleServiceViewState extends State<SingleServiceView> {


  @override
  Widget build(BuildContext context) {
    ServiceCategory category = ServiceCategory.find(
        widget._service.category, context);
    final User _user = AuthService().getCurrentUser(context);
    return Scaffold(
//                    backgroundColor: category.color(context),
      appBar: AppBar(
        backgroundColor: category.color(context),
        centerTitle: true,
        title: Text(
          category != null ? category.name : '',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Table(
                children: [
                  TableRow(children: [
                    Text(
                      "Id:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                          color: MyApp
                              .defaultPrimaryColor),
                    ),
                    Text(
                      widget._service.id,
                      textAlign: TextAlign.center,
                      style: TextStyle(
//                                          fontWeight: FontWeight.bold,
                          color: MyApp.isDark(
                              context)
                              ? Colors.white
                              : Colors.black45),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      "Estellungsdatum:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                          color: MyApp
                              .defaultPrimaryColor),
                    ),
                    Text(
                      widget._service
                          .createdAt
                          .toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
//                                          fontWeight: FontWeight.bold,
                          color: MyApp.isDark(
                              context)
                              ? Colors.white
                              : Colors.black45),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      "Status:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                          color: MyApp
                              .defaultPrimaryColor),
                    ),
                    Text(
                      widget._service
                          .status
                          .toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
//                                          fontWeight: FontWeight.bold,
                          color: MyApp.isDark(
                              context)
                              ? Colors.white
                              : Colors.black45),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      "Helfer:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                          color: MyApp
                              .defaultPrimaryColor),
                    ),
                    Text(
                      widget._service
                          .helpProvider ==
                          null
                          ? 'N/A'
                          : widget._service
                          .helpProvider,
                      textAlign: TextAlign.center,
                      style: TextStyle(
//                                          fontWeight: FontWeight.bold,
                          color: MyApp.isDark(
                              context)
                              ? Colors.white
                              : Colors.black45),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      "Hilfesuchender(in):",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                          color: MyApp
                              .defaultPrimaryColor),
                    ),
                    Text(
                      widget._service
                          .helpReceiver ==
                          null
                          ? 'Keine'
                          : widget._service
                          .helpReceiver,
                      textAlign: TextAlign.center,
                      style: TextStyle(
//                                          fontWeight: FontWeight.bold,
                          color: MyApp.isDark(
                              context)
                              ? Colors.white
                              : Colors.black45),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      "Location:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                          color: MyApp.isDark(
                              context)
                              ? Colors.white
                              : Colors.black),
                    ),
                    Text(
                      _user.location == null
                          ? 'N/A'
                          : _user.location
                          .toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
//                                          fontWeight: FontWeight.bold,
                          color: MyApp.isDark(
                              context)
                              ? Colors.white
                              : Colors.black45),
                    ),
                  ]),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Beschreibung:',
                style: TextStyle(
                    color: MyApp
                        .defaultPrimaryColor),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget._service.description,
//                          style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      'bearbeiten',
                      style: TextStyle(
                          color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  RaisedButton(
                    color: Colors.red,
                    child: Text(
                      'löschen',
                      style: TextStyle(
                          color: Colors.white),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder:
                              (_) => AlertDialog(
                            title: Text(
                                'Wollen Sie wirklich diese Serviceanfrage löschen ?'),
                            actions: <
                                Widget>[
                              FlatButton(
                                child:
                                Text(
                                  'ja',
                                  style: TextStyle(
                                      color:
                                      Colors.red),
                                ),
                                onPressed:
                                    () {
                                      widget._service
                                      .delete();
                                  _goBackToMyList();
                                },
                              ),
                              FlatButton(
                                child:
                                Text(
                                  'abbrechen',
                                  style: TextStyle(
                                      color:
                                      Colors.grey),
                                ),
                                onPressed:
                                    () {
                                  Navigator.of(context)
                                      .pop();
                                },
                              ),
                            ],
                          ));
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  void _goBackToMyList() {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }
}
