import 'package:coronahelpapp/HomePage.dart';
import 'package:coronahelpapp/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBarWidget extends StatelessWidget {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: 160.0,
        child: Stack(
          children: <Widget>[
            Container(
              color: MyApp.getModeColor(context),
              width: MediaQuery.of(context).size.width,
              height: 160.0,
              child: Center(
                child: Text(
                  HomePage.titleString,
                  style: TextStyle(color: MyApp.getTitleColor(context), fontSize: 22.0),
                ),
              ),
            ),
            Positioned(
              top: 100.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1.0),
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.5), width: 1.0),
                      color: MyApp.isDark(context)?Colors.black87:Colors.white),
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
                              contentPadding:
                              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
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
            )
          ],
        ),
      ),
    );
  }
}