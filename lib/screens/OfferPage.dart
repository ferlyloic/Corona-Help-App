import 'package:coronahelpapp/main.dart';
import 'package:coronahelpapp/models/service_category.dart';
import 'package:coronahelpapp/screens/offer/categories_list_view.dart';
import 'package:coronahelpapp/screens/offer/create_offer_view.dart';
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
  ServiceCategory chosenCategory;
  String textOverCategories ='Wähle eine Kategorie aus';
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
      body: chosenCategory!= null ? CreateOfferView(setChosenCategory: setChosenCategory,category: chosenCategory,): SingleChildScrollView(
    child: Center(
    child: Column(
        children: [
          SizedBox(height: 20.0),
          Text(
            this.textOverCategories,
            style: TextStyle(fontSize: 20, color: MyApp.defaultPrimaryColor),
          ),
          SizedBox(height: 20.0),
          CategoriesListWidget(setChosenCategory: setChosenCategory),
        ],
      ),
    )
    )
    );
  }

  setChosenCategory(ServiceCategory category) {
    chosenCategory = category;
    setState(() {
      this.textOverCategories = category == null? 'Wähle eine Kategorie aus': "Kategory ${category.name} ausgewählt.";
    });
//    // flutter defined function
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        // return object of type Dialog
//        return AlertDialog(
//          title:  Text("Kategory $chosenCategoryIndex ausgewählt."),
//          content: Text("Alert Dialog body"),
//          actions: <Widget>[
//            // usually buttons at the bottom of the dialog
//            new FlatButton(
//              child: new Text("Close"),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
//        );
//      },
//    );
  }
}

