import 'package:coronahelpapp/main.dart';
import 'package:flutter/material.dart';

class OfferPage extends StatefulWidget {
  OfferPage({Key key}) : super(key: key);
  static const String titleString = "Offer";

  @override
  State<StatefulWidget> createState() {
    return _OfferPageState();
  }
}

class _OfferPageState extends State<OfferPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          OfferPage.titleString,
          style: TextStyle(color: MyApp.getTitleColor(context)),
        ),
      ),
    );
  }
}
