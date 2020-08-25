import 'package:calendarro/calendarro.dart';
import 'package:calendarro/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dio/dio.dart';

class CoolListViewPage extends StatefulWidget {
  @override
  _CoolListViewPageState createState() => _CoolListViewPageState();
}

class _CoolListViewPageState extends State<CoolListViewPage> {
  final dio = new Dio(); // for http requests
  Widget _appBarTitle = new Text('Search...');
  Icon _searchIcon = new Icon(Icons.search);
  final String title = "Calendarro";
  Calendarro monthCalendarro;

  @override
  Widget build(BuildContext context) {
    var startDate = DateUtils.getFirstDayOfCurrentMonth();
    var endDate = DateUtils.getLastDayOfNextMonth();
    monthCalendarro = Calendarro(
        startDate: startDate,
        endDate: endDate,
        displayMode: DisplayMode.MONTHS,
        selectionMode: SelectionMode.MULTI,
        weekdayLabelsRow: CustomWeekdayLabelsRow(),
        onTap: (date) {
          print("onTap: $date");
        });
    return Column(
      children: <Widget>[
//          Container(
//            child: Calendarro(),
//          ),
        Container(height: 32.0),
        monthCalendarro
      ],
    );
  }
}

class CustomWeekdayLabelsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: Text("Mo", textAlign: TextAlign.center)),
        Expanded(child: Text("Di", textAlign: TextAlign.center)),
        Expanded(child: Text("Mi", textAlign: TextAlign.center)),
        Expanded(child: Text("Do", textAlign: TextAlign.center)),
        Expanded(child: Text("Fr", textAlign: TextAlign.center)),
        Expanded(child: Text("Sa", textAlign: TextAlign.center)),
        Expanded(child: Text("So", textAlign: TextAlign.center)),
      ],
    );
  }
}
