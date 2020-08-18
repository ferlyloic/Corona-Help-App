import 'package:coronahelpapp/models/user.dart';
import 'package:coronahelpapp/screens/HomePage.dart';
import 'package:coronahelpapp/main.dart';
import 'package:coronahelpapp/screens/auth/authenticate.dart';
import 'package:coronahelpapp/screens/shared/ConfigPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ListMyServicesPage.dart';
import 'CreateServicePage.dart';
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
  // list of all app routes.
  static List<Widget> _routes = [
    HomePage(),
    CreateServicePage(),
    ListMyServicesPage(),
    ProfilePage(),
    ConfigPage(),
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
    return _getAuthViewOrNavigation();
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

  Widget _getAuthViewOrNavigation() {
    return Provider.of<User>(context) == null
        ? AuthenticateView()
        : Scaffold(
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
            title: Text(CreateServicePage.titleString),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text(ListMyServicesPage.titleString),
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
}
