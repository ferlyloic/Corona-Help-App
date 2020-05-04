import 'package:coronahelpapp/FindPage.dart';
import 'package:coronahelpapp/HomePage.dart';
import 'package:coronahelpapp/OfferPage.dart';
import 'package:coronahelpapp/ProfilePage.dart';
import 'package:coronahelpapp/main.dart';
import 'package:flutter/material.dart';

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
    FindPage(),
    OfferPage(),
    ProfilePage()
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
        unselectedItemColor: Colors.grey,
//        selectedItemColor: MyApp.defaultPrimaryColor,
        selectedItemColor:MyApp.getModeInvertedColor(context),
        backgroundColor: MyApp.getModeColor(context),
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Suchen'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text('Anbieten'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Profil'),
          ),
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
