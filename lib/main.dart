import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronahelpapp/models/service.dart';
import 'package:coronahelpapp/models/service_category.dart';
import 'package:coronahelpapp/models/user.dart';
import 'package:coronahelpapp/screens/BottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static Color defaultPrimaryColor = Colors.orange;
  static Color defaultAccentColor = Colors.amberAccent;
  static const kGoogleApiKey = "AIzaSyBQCnZmVPPtw6qhnhB6w9IKa99zNDrydxA";

//  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  static const String apiQueryLanguage = 'de';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//    try {
//      http.get('https://www.google.com').then((response) {
//        if (response.statusCode == 200) {
////        var jsonResponse = convert.jsonDecode(response.body);
////        var itemCount = jsonResponse['totalItems'];
//          print('connected');
//        } else {
//          print('Request failed with status: ${response.statusCode}.');
//        }
//      });
//    } catch(e){
////    print(e.message);
//      print('No internet connection');
//    }
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(value: User().user),
        StreamProvider<QuerySnapshot>.value(value: User().dataFromFireStore),
        StreamProvider<List<User>>.value(value: User().users),
        StreamProvider<List<ServiceCategory>>.value(
            value: ServiceCategory().categories),
        StreamProvider<List<Service>>.value(value: Service().services),
      ],
      child: MaterialApp(
        title: 'Corona Help App',
        theme: ThemeData(
          primarySwatch: defaultPrimaryColor,
          accentColor: defaultAccentColor,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: defaultPrimaryColor,
          accentColor: defaultAccentColor,
        ),
        home: MyBottomNavigationBar(),
      ),
    );
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
