
import 'package:coronahelpapp/main.dart';
import 'package:coronahelpapp/models/service_category.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoriesListWidget extends StatefulWidget {
  final Function setChosenCategory;

  const CategoriesListWidget({Key key, this.setChosenCategory}) : super(key: key);
  @override
  CategoriesListWidgetState createState() => CategoriesListWidgetState();

}
class CategoriesListWidgetState extends State<CategoriesListWidget> {

  List<ServiceCategory> categoryList = ServiceCategory.all();

  @override
  Widget build(BuildContext context) {
    List<Widget> categoryWidgetList = [ ];
    for(ServiceCategory cat in categoryList){
      categoryWidgetList.add(CategoryWidget(setChosenCategory: widget.setChosenCategory, category: cat));
    }
   return Column(
     children: categoryWidgetList
   );
  }
}

class CategoryWidget extends StatelessWidget {
  final ServiceCategory category;
  final Function setChosenCategory;
  const CategoryWidget({Key key, this.category, this.setChosenCategory}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { _categoryChosenAction();},
      child: Card(
              color: MyApp.getModeColor(context),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage("assets/default.png")),
                    title: Text(this.category.name),
                    subtitle: Text(this.category.name),
                    trailing: Text(this.category.name),
                  )
                ],
              ),
      )
    );
  }
  void _categoryChosenAction() {
    setChosenCategory(this.category);
    print(this.category.name);
  }

  Widget myDetails(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
                this.category.name,
                style: TextStyle(
                    color: MyApp.isDark(context) ?Colors.black54 : Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              )),
        ),

        Container(
            child: Text(
              this.category.name,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
      ],
    );
  }

}