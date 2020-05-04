import 'package:coronahelpapp/main.dart';
import 'package:flutter/material.dart';

class OfferPage extends StatefulWidget {
  OfferPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OfferPageState();
  }
}
class _OfferPageState extends State<OfferPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Offer", style:  TextStyle(color: MyApp.getModeInvertedColor(context)),),
      ),
    );
  }
}

