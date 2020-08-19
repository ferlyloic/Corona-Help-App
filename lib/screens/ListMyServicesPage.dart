import 'package:coronahelpapp/main.dart';
import 'package:coronahelpapp/models/service.dart';
import 'package:coronahelpapp/models/service_category.dart';
import 'package:coronahelpapp/models/user.dart';
import 'package:coronahelpapp/models/user_role.dart';
import 'package:coronahelpapp/screens/auth/authenticate.dart';
import 'package:coronahelpapp/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListMyServicesPage extends StatefulWidget {
  static const String titleString = "Meine Liste";

  @override
  State<StatefulWidget> createState() {
    return _ListMyServicesPageState();
  }
}

class _ListMyServicesPageState extends State<ListMyServicesPage> {
  List<dynamic> _usersList = [];


  List<Service> _userServices;

  User _user;

  Future<void> _getData() async {
    if (_usersList != null)
      setState(() {
        fetchCategories();
      });
  }

  void fetchCategories() async {

    final String apiUrl = "https://randomuser.me/api/?results=${_userServices != null ? _userServices.length:'10'
    }&nat=de";
    print(apiUrl);
    var result = await http.get(apiUrl);
    setState(() {
      _usersList = json.decode(result.body)['results'];
    });
  }

  String _name(dynamic user) {
    return user['name']['title'] +
        " " +
        user['name']['first'] +
        " " +
        user['name']['last'];
  }

  String _location(dynamic user) {
    return user['location']['city'];
  }

  String _age(Map<dynamic, dynamic> user) {
    return "Age: " + user['dob']['age'].toString();
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Widget _buildList() {
    _user = AuthService().getCurrentUser(context);
    if(_user != null) {
      List<User> temp = [];
//      print(_userServices);
//      for(Service s in _userServices){
//        print(s.helpReceiver);
//      }
      _userServices = Service.all(context);
      _userServices?.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      _userServices = _userServices?.where((Service element) =>
      (element.helpProvider == _user.id) ||
              (element.helpReceiver == _user.id)
          )?.toList();
//      print(_userServices?.length);
    }
    return _getServicesListWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          ListMyServicesPage.titleString,
          style: TextStyle(color: MyApp.getTitleColor(context)),
        ),
      ),
      body: _buildList(),
    );
  }

  _getServicesListWidget() {

//    print(_userServices?.length);

    return _userServices != null
        ?
        RefreshIndicator(
      child: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: _userServices.length,
          itemBuilder: (BuildContext context, int index) {
            ServiceCategory category = ServiceCategory.find(_userServices[index].category, context);
            return GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Scaffold(
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
                            SizedBox(height: 20,),
                            Table(
                              children: [
                                TableRow(children: [
                                  Text(
                                    "Id:",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: MyApp.defaultPrimaryColor),
                                  ),
                                  Text(
                                    _userServices[index].id,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
//                                          fontWeight: FontWeight.bold,
                                        color: MyApp.isDark(context)
                                            ? Colors.white
                                            : Colors.black45),
                                  ),
                                ]),
                                TableRow(children: [
                                  Text(
                                    "Estellungsdatum:",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: MyApp.defaultPrimaryColor),
                                  ),
                                  Text(
                                   _userServices[index].createdAt.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
//                                          fontWeight: FontWeight.bold,
                                        color: MyApp.isDark(context)
                                            ? Colors.white
                                            : Colors.black45),
                                  ),
                                ]),
                                TableRow(children: [
                                  Text(
                                    "Status:",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: MyApp.defaultPrimaryColor),
                                  ),
                                  Text(
                                    _userServices[index].status.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
//                                          fontWeight: FontWeight.bold,
                                        color: MyApp.isDark(context)
                                            ? Colors.white
                                            : Colors.black45),
                                  ),
                                ]),
                                TableRow(children: [
                                  Text(
                                    "Helfer:",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: MyApp.defaultPrimaryColor),
                                  ),
                                  Text(
                                    _userServices[index].helpProvider == null? 'N/A': _userServices[index].helpProvider,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
//                                          fontWeight: FontWeight.bold,
                                        color: MyApp.isDark(context)
                                            ? Colors.white
                                            : Colors.black45),
                                  ),
                                ]),
                                TableRow(children: [
                                  Text(
                                    "Hilfesuchender(in):",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: MyApp.defaultPrimaryColor),
                                  ),
                                  Text(
                                    _userServices[index].helpReceiver == null? 'Keine': _userServices[index].helpReceiver,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
//                                          fontWeight: FontWeight.bold,
                                        color: MyApp.isDark(context)
                                            ? Colors.white
                                            : Colors.black45),
                                  ),
                                ]),
                                TableRow(children: [
                                  Text(
                                    "Location:",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: MyApp.isDark(context)
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                  Text(
                                    _user.location==null? 'N/A':_user.location.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
//                                          fontWeight: FontWeight.bold,
                                        color: MyApp.isDark(context)
                                            ? Colors.white
                                            : Colors.black45),
                                  ),
                                ]),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Text('Beschreibung:',
                              style: TextStyle(color: MyApp.defaultPrimaryColor),),
                            SizedBox(height: 10,),
                            Text(_userServices[index].description,
//                          style: TextStyle(color: Colors.white),
                            ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                          RaisedButton(
                            color: Colors.blue,
                          child: Text('bearbeiten', style: TextStyle(color: Colors.white),),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                            RaisedButton(
                              color: Colors.red,
                            child: Text('löschen', style: TextStyle(color: Colors.white),),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                title: Text('Wollen Sie wirklich diese Serviceanfrage löschen ?'),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text('ja', style: TextStyle(color: Colors.red),),
                                        onPressed: () {
                                          _userServices[index].delete();
                                         _goBackToMyList();
                                        },
                                      ),
                                      FlatButton(
                                        child: Text('abbrechen', style: TextStyle(color: Colors.grey),),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  )
                              );
                            },
                          ),],)
                      ],
                  ),
                      ),
                    ),
                )));
                return;
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
//                    backgroundColor: category.color(context),
                          title: Text(
                            category != null ? category.name : '',
                            style: TextStyle(
                              color:
                              MyApp.isDark(context)
                                  ? Colors.white
                                  :
                              category.color(context),
                            ),
                          ),
                          content: Container(
                      height: 200,
                      child: Column(
                        children: <Widget>[
                        Text('Beschreibung:',
                      style: TextStyle(color: MyApp.defaultPrimaryColor),),
                        SizedBox(),
                        Text(_userServices[index].description,
//                          style: TextStyle(color: Colors.white),
                        ),
                      ],),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('bearbeiten', style: TextStyle(color: Colors.blue),),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      FlatButton(
                        child: Text('löschen', style: TextStyle(color: Colors.red),),
                        onPressed: () {
                          _userServices[index].delete();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
              child: Card(

//              color: MyApp.getModeColor(context),
                color: category.color(context),
                child: Column(
                  children: <Widget>[
                    ListTile(
//                    leading: CircleAvatar(
//                        radius: 30,
//                        backgroundImage: AssetImage('assets/default_user.png')),
                      title: Text(category != null
                          ? category.name
                          : '',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                      ),
//                    subtitle: Text(_userServices[index].id),
                      trailing: Text( _userServices[index].getFormattedCreatedAt,
                        style: TextStyle(
                          color: Colors.white,
                        ),),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Text(
                          _userServices[index].description,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                        ),
//                        Center(
//                          child: SingleChildScrollView(
//                            child: HtmlView(
//                              data:
//                              """<p>Lorem ipsum sollicitudin velit leo proin vivamus augue dictumst,
//                              litora commodo netus ut amet auctor eu.</p>\r<p>Habitasse sagittis curabitur
//                              ligula non convallis scelerisque, purus tristique sed aliquam enim,
//                              phasellus ut integer lorem posuere.</p>\r<p>Consequat quis mollis vulputate curabitur primis,
//                              leo platea fusce neque primis, turpis sociosqu hendrerit gravida.</p>\r""",
//                              onLaunchFail: (url) { // optional, type Function
//                                print("launch $url failed");
//                              },
//                              scrollable: false, //false to use MarksownBody and true to use Marksown
//                            ),
//                          ),
//                        ),
                        ]
                      ),
                      padding: EdgeInsets.fromLTRB(20, 0 , 10, 10),
                      alignment: Alignment.bottomLeft,
                    )
                  ],
                ),
              ),
            );
          }),
      onRefresh: _getData,
    )
    :  Container( child:  Text('Sie haben noch keine Einträge'),);
//    : Center(child: CircularProgressIndicator());
  }

  void _goBackToMyList() {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }


}
