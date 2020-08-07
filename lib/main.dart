import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronahelpapp/models/service_category.dart';
import 'package:coronahelpapp/models/user.dart';
import 'package:coronahelpapp/screens/BottomNavigationBar.dart';
import 'package:coronahelpapp/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static Color defaultPrimaryColor = Colors.orange;
  static const kGoogleApiKey = "AIzaSyBQCnZmVPPtw6qhnhB6w9IKa99zNDrydxA";
//  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  static const String apiQueryLanguage = 'de';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: User(null).user,
        child: StreamProvider<List<ServiceCategory>>.value(
          value: ServiceCategory().categories,
          child: StreamProvider<QuerySnapshot>.value(
            value: User(null).dataFromFireStore,
            child: MaterialApp(
              title: 'Corona Help App',
              theme: ThemeData(
                primarySwatch: defaultPrimaryColor,
                accentColor: defaultPrimaryColor,
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                primarySwatch: defaultPrimaryColor,
                accentColor: defaultPrimaryColor,
              ),
              home: MyBottomNavigationBar(),
            ),
          ),
        ));
  }

  static Color getModeColor(BuildContext context) {
    return getColor(context, Brightness.dark);
  }

  static Color getColor(BuildContext context, Brightness brightness) {
    if (MediaQuery.of(context).platformBrightness == brightness) {
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
    return MediaQuery.of(context).platformBrightness == Brightness.dark;
  }

  static Color getTitleColor(BuildContext context) {
    if (MediaQuery.of(context).platformBrightness == Brightness.light) {
      return Colors.white;
    }
    return MyApp.defaultPrimaryColor;
  }
}
