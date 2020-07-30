import 'package:coronahelpapp/main.dart';
import 'package:coronahelpapp/screens/offer/categories_list_view.dart';
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
      body: SingleChildScrollView(
    child: Center(
    child: Column(
        children: [
          SizedBox(height: 20.0),
          Text(
            'Wähle eine Kategorie aus',
            style: TextStyle(fontSize: 20, color: MyApp.defaultPrimaryColor),
          ),
          CategoriesListWidget(),
        ],
      ),
    )
    )
    );
  }
}

