import 'package:flutter/material.dart';
import 'package:myfinal/components/rounded_button.dart';
import 'package:csv/csv.dart';
import 'package:myfinal/screens/Csv.dart';
import 'Feedback.dart';
class ChooseCsv extends StatefulWidget {
  static String id = 'choose_csv';
  @override
  _ChooseCsvState createState() => _ChooseCsvState();
}

class _ChooseCsvState extends State<ChooseCsv> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RoundedButton(title:"Weather",onPressed: (){
              csvName='Weather';
              nameFeed=csvName;
              Navigator.pushNamed(context, TableLayout.id);
            }),
            RoundedButton(title:"Street",onPressed: (){
              csvName='Street';
              nameFeed=csvName;
              Navigator.pushNamed(context, TableLayout.id);
            }),
            RoundedButton(title:"County",onPressed: (){
              csvName='County';
              nameFeed=csvName;
              Navigator.pushNamed(context, TableLayout.id);
            }),
            RoundedButton(title:"City",onPressed: (){
              csvName='City';
              nameFeed=csvName;
              Navigator.pushNamed(context, TableLayout.id);
            }),
          ],
        ),
      ),
    );
  }
}
