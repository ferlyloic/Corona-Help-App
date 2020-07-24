import 'package:coronahelpapp/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FindPage extends StatefulWidget {
  static const String titleString = "Search";
  @override
  State<StatefulWidget> createState() {
    return _FindPageState();
  }
}
class _FindPageState extends State<FindPage>{
  List<dynamic> _users = [];
  final String apiUrl = "https://randomuser.me/api/?results=10";

  Future<void> _getData() async {
    if(_users!=null)
    setState(() {

      fetchCategories();
    });
  }

  void fetchCategories() async {
    print(apiUrl);
    var result = await http.get(apiUrl);
    setState(() {
      _users = json.decode(result.body)['results'];
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
    return user['location']['country'];
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

    return _users?.length != 0
        ? RefreshIndicator(
      child: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: _users.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            _users[index]['picture']['large'])),
                    title: Text(_name(_users[index])),
                    subtitle: Text(_location(_users[index])),
                    trailing: Text(_age(_users[index])),
                  )
                ],
              ),
            );
          }),
      onRefresh: _getData,
    )
        : Center(child: CircularProgressIndicator());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(FindPage.titleString,
          style:  TextStyle(
              color: MyApp.getTitleColor(context)
          ),
        ),
      ),
      body:  _buildList(),
    );
  }
}

