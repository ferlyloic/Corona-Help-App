import 'package:coronahelpapp/BottomNavigationBar.dart';
import 'package:coronahelpapp/HomePage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static Color defaultPrimaryColor = Colors.amber;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Corona Help',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: defaultPrimaryColor,
        accentColor: defaultPrimaryColor,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: defaultPrimaryColor,
        accentColor: defaultPrimaryColor,
      ),
      home: MyBottomNavigationBar(),
    );
  }

  static Color getModeColor(BuildContext context) {
    return getColor(context, Brightness.dark);
  }

  static Color getColor(BuildContext context, Brightness brightness) {
    if (MediaQuery
        .of(context)
        .platformBrightness == brightness) {
//      Color defaultColor = MyApp.defaultPrimaryColor;
//      HSLColor hue = HSLColor.fromColor(defaultColor);
//      print(hue.hue);
//      hue = HSLColor.fromAHSL(hue.alpha, (hue.hue + 180) % 360, hue.saturation, hue.lightness);
//      print(hue.hue);
//      defaultColor = hue.toColor();
//        return defaultColor;
      return Colors.black12;
    }
    return MyApp.defaultPrimaryColor;
  }

  static Color getModeInvertedColor(BuildContext context) {
    return getColor(context, Brightness.light);
  }

  static bool isDark(BuildContext context) {
    return MediaQuery
        .of(context)
        .platformBrightness == Brightness.dark;
  }

  static Color getTitleColor(BuildContext context) {
    if (MediaQuery
        .of(context)
        .platformBrightness == Brightness.light) {
      return Colors.white;
    }
    return MyApp.defaultPrimaryColor;
  }
}

