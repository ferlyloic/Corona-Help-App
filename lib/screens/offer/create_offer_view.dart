import 'package:coronahelpapp/models/service_category.dart';
import 'package:coronahelpapp/screens/CoolListView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateOfferView extends StatefulWidget {
  final Function setChosenCategory;
  final ServiceCategory category;

  const CreateOfferView({Key key, this.setChosenCategory, this.category})
      : super(key: key);

  CreateOfferViewState createState() => CreateOfferViewState();
}

class CreateOfferViewState extends State<CreateOfferView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Text('Sie haben die Kategorie ${widget.category.name} ausgewählt.'),
            CoolListViewPage(),
            FlatButton(
              onPressed: () {
                widget.setChosenCategory(null);
              },
              child: Text('abbrechen'),
            ),
          ],
        ),
      ),
    );
  }
}
