import 'package:coronahelpapp/screens/HomePage.dart';
import 'package:coronahelpapp/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBarWidget extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _scaffoldKey,
      child: Column(
//        height: 160.0,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1.0),
                  border: Border.all(
                      color: Colors.grey.withOpacity(0.5), width: 1.0),
                  color: MyApp.isDark(context) ? Colors.black87 : Colors.white),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: MyApp.defaultPrimaryColor,
                    ),
                    onPressed: () {
                      print("your menu action here");
                      _scaffoldKey.currentState.openDrawer();
                    },
                  ),
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.black,
//                          keyboardType: inputType,
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        hintText: "Search",
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: MyApp.defaultPrimaryColor,
                    ),
                    onPressed: () {
                      print("your menu action here");
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.notifications,
                      color: MyApp.defaultPrimaryColor,
                    ),
                    onPressed: () {
                      print("your menu action here");
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
