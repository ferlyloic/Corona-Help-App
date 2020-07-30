
import 'package:coronahelpapp/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoriesListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> categoryList = [
      'Test 01',
      'Test 02',
      'Test 03',
      'Test 04',
      'Test 05',
      'Test 06',
      'Test 07',
      'Test 08',
      'Test 09',
      'Test 10',
      'Test11',
    ];
    List<CategoryWidget> categoryWidgetList = [];
    for(String cat in categoryList){
      categoryWidgetList.add(CategoryWidget(name: cat));
    }

   return Column(
     children: categoryWidgetList
   );
  }
}

class CategoryWidget extends StatelessWidget {
  final String name;

  const CategoryWidget({Key key, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: FittedBox(
          child:FlatButton(
              onPressed:() {
              print(this.name);
              },
              child: Material(
                    color: MyApp.defaultPrimaryColor,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Colors.amberAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: myDetails(context),
                    ),
                  ),
                  Container(
                    width: 250,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(24.0),
                      child: Image(
                        fit: BoxFit.contain,
                        alignment: Alignment.topRight,
                        image: NetworkImage(
                            "https://images.unsplash.com/photo-1495147466023-ac5c588e2e94?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80"),
                      ),
                    ),
                  ),
                ],
              ))),
        ),
      ),
    );
  }
  Widget myDetails(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
                this.name,
                style: TextStyle(
                    color: MyApp.isDark(context) ?Colors.black54 : Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              )),
        ),

        Container(
            child: Text(
              this.name,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
      ],
    );
  }

}