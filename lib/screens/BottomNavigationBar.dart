import 'package:coronahelpapp/screens/HomePage.dart';
import 'package:coronahelpapp/main.dart';
import 'package:coronahelpapp/screens/shared/address_autocompletion.dart';
import 'package:coronahelpapp/screens/shared/storage.dart';
import 'package:flutter/material.dart';
import 'CoolListView.dart';
import 'FindPage.dart';
import 'OfferPage.dart';
import 'ProfilePage.dart';

class MyBottomNavigationBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyBottomNavigationBarState();
  }
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar>
    with WidgetsBindingObserver {
  int _selectedIndex = 0;
  static List<Widget> _routes = [
    HomePage(),
    OfferPage(),
    FindPage(),
    ProfilePage(),
    MyHomePage(),
//    AddressAutocompletion()
//    TabbedAppBarSample(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _routes[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        unselectedItemColor:
            MyApp.isDark(context) ? Colors.grey : Colors.white54,
//        selectedItemColor: MyApp.defaultPrimaryColor,
        selectedItemColor: MyApp.isDark(context)
            ? MyApp.getModeInvertedColor(context)
            : Colors.white,
        backgroundColor: MyApp.getModeColor(context),
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(HomePage.titleString),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text(OfferPage.titleString),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text(FindPage.titleString),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text(ProfilePage.titleString),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text("Setting"),
          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.details),
//            title: Text('Tab'),
//          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    final Brightness brightness =
        WidgetsBinding.instance.window.platformBrightness;
    //inform listeners and rebuild widget tree
  }
}
