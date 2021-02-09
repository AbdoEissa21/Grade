import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'Feedback.dart';
import 'package:flutter/services.dart' show rootBundle;
String csvName;

class TableLayout extends StatefulWidget {
  static String id = 'csv';
  @override
  _TableLayoutState createState() => _TableLayoutState();
}
Axis sel=Axis.horizontal;
Axis hor=Axis.horizontal;
Axis ver=Axis.vertical;
bool _dir=false;
class _TableLayoutState extends State<TableLayout> {
  List<List<dynamic>> data = [];
  loadAsset() async {
    final myData = await rootBundle.loadString("assets/$csvName.csv");
    List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);
    print(csvTable);
    data = csvTable;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () async {
            await loadAsset();
            //print(data);
          }),
      appBar: AppBar(
        actions: <Widget>[
          RaisedButton(child: Text('Feedback'),color: Colors.blueAccent,onPressed: (){Navigator.pushNamed(context, feedback.id);

          },)


        ],
      title: Text("$csvName Conditions For Every State ",style: TextStyle(fontSize: 15),),
      ),

      body: ListView(scrollDirection: sel,
          children:<Widget>[ GestureDetector(child: Table(

            defaultColumnWidth: FixedColumnWidth(145.0),

            border: TableBorder.all(width: 2.0),
            children: data.map((item) {
              return TableRow(
                  children: item.map((row) {
                    return Container(

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          row.toString(),
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    );
                  }).toList());
            }).toList(),
          ),
            onDoubleTap: (){
setState(() {

});
            if(_dir==false) {
              sel = ver;
              _dir=true;

            }

            else{
              sel=hor;
              _dir=false;
            }
            setState(() {

            });
            },
          ),
          ]),
    );
  }
}