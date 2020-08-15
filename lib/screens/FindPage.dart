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

class FindPage extends StatefulWidget {
  static const String titleString = "Liste";

  @override
  State<StatefulWidget> createState() {
    return _FindPageState();
  }
}

class _FindPageState extends State<FindPage> {
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
    _userServices = Service.all(context);

    if(_user != null) {
      List<User> temp = [];
      print(_userServices);
//      for(Service s in _userServices){
//        print(s.helpReceiver);
//      }
      _userServices = _userServices?.where((Service element) =>
      (element.helpProvider == _user.id) ||
              (element.helpReceiver == _user.id)
          )?.toList();
      print(_userServices?.length);
    }
    return _getServicesListWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          FindPage.titleString,
          style: TextStyle(color: MyApp.getTitleColor(context)),
        ),
      ),
      body: _buildList(),
    );
  }

  _getServicesListWidget() {

    print(_userServices?.length);

    return _userServices != null
        ?
        RefreshIndicator(
      child: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: _userServices.length,
          itemBuilder: (BuildContext context, int index) {
            ServiceCategory category = ServiceCategory.find(_userServices[index].category, context);
            return Card(
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
                        : ''
                    ),
//                    subtitle: Text(_userServices[index].id),
                    trailing: Text('seit '+ _getDatetimeDiff(_userServices[index].createdAt)),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                        _userServices[index].description,
                      ),
                        Center(
                          child: SingleChildScrollView(
                            child: HtmlView(
                              data:
                              """<p>Lorem ipsum sollicitudin velit leo proin vivamus augue dictumst, 
                              litora commodo netus ut amet auctor eu.</p>\r<p>Habitasse sagittis curabitur 
                              ligula non convallis scelerisque, purus tristique sed aliquam enim, 
                              phasellus ut integer lorem posuere.</p>\r<p>Consequat quis mollis vulputate curabitur primis, 
                              leo platea fusce neque primis, turpis sociosqu hendrerit gravida.</p>\r""",
                              onLaunchFail: (url) { // optional, type Function
                                print("launch $url failed");
                              },
                              scrollable: false, //false to use MarksownBody and true to use Marksown
                            ),
                          ),
                        ),
                      ]
                    ),
                    padding: EdgeInsets.fromLTRB(20, 0 , 10, 10),
                    alignment: Alignment.bottomLeft,
                  )
                ],
              ),
            );
          }),
      onRefresh: _getData,
    )
    :  Container( child:  Text('Sie haben noch keine Einträge'),);
//    : Center(child: CircularProgressIndicator());
  }

  String _getDatetimeDiff(DateTime dateTime) {
    if(dateTime.difference(DateTime.now()).inDays > 0){
      return dateTime.difference(DateTime.now()).inDays.toString()+' Tag(e)';
    }
    return dateTime.hour.toString() + ':'+ dateTime.minute.toString();
  }
}
