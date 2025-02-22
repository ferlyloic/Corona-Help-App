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
        debugShowCheckedModeBanner: false,
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
