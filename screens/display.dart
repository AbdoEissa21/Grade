import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myfinal/components/Location.dart';
import 'package:flutter/material.dart';
import 'map.dart';
import '../screens/NameAndMobile.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'chat_screen.dart';
import 'Rate.dart';
final _fireStore = FirebaseFirestore.instance;

String typeneeded;
String nameOfRequest;
String state;
double longOfUser, latOfUser, latCar, longCar;
bool accepted = false;
DocumentSnapshot details;
String Rate;
class CloudFirestoreSearch extends StatefulWidget {
  static String id = 'cloud';
  @override
  _CloudFirestoreSearchState createState() => _CloudFirestoreSearchState();
}

class _CloudFirestoreSearchState extends State<CloudFirestoreSearch> {

  createAlert(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('user busy'),
            actions: <Widget>[
              MaterialButton(
                  child: Text('ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }

  var area = ["Giza", "Cairo", "October", "Alex", "Nasr-City", "Madi"];
  var sort = ['Price', 'Rate'];
  String currentSort;
  String currentArea;
  bool order = false;
  String input;
  String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Card(
            child: Row(
          children: [
            DropdownButton<String>(
              hint: Text('Chose Area'),
              items: area.map((String dropDownString) {
                return DropdownMenuItem<String>(
                  value: dropDownString,
                  child: Text(dropDownString),
                );
              }).toList(),
              onChanged: (newValueSelected) {
                setState(() {
                  this.currentArea = newValueSelected;

                });
              },
              value: currentArea,
            ),
            SizedBox(
              width: 15,
            ),
            DropdownButton<String>(
              hint: Text('Sort'),
              items: sort.map((String dropDownString) {
                return DropdownMenuItem<String>(
                  value: dropDownString,
                  child: Text(dropDownString),
                );
              }).toList(),
              onChanged: (newValueSelected) {
                setState(
                  () {
                    this.currentSort = newValueSelected;
                  },
                );
              },
              value: currentSort,
            ),
          ],
        )),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: (currentArea != "" && currentArea != null)
            ? Firestore.instance
                .collection('provider')
                .where('Area', isEqualTo: currentArea)
                .where('')
                .snapshots()
            : Firestore.instance
                .collection("provider")
                .where('service', isEqualTo: typeneeded)
                .snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data.docs[index];
                    details = data;
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0, top: 15),
                        child: Row(
                          children: <Widget>[
                            Row(children: [Text(
                              data['Name'],
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                 data['Price']+'LE',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                data['Rate'],
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              MaterialButton(
                                  height: 40.0,
                                  minWidth: 40,
                                  color: Theme.of(context).primaryColor,
                                  textColor: Colors.white,
                                  child: Text("Rate"),
                                  onPressed: () async {
                                    data.data();
                                    details = data;
                                    Navigator.pushNamed(context, rate.id);
                                  }
                                  ),
                              SizedBox(width: 30,),
                              MaterialButton(
                                height: 40.0,
                                minWidth: 100,
                                color: Theme.of(context).primaryColor,
                                textColor: Colors.white,
                                child: Text(nameOfRequest),
                                onPressed: () async {
                                  if (nameOfRequest == 'Navigate') {
                                    longOfUser = await data.get('long');
                                    latOfUser = await data.get('lat');
                                    _fireStore.collection('Analysis').add({


                                      'lat': latCar,
                                      'long': longCar,
                                      'Area':area,
                                      'ServiceType':details.get('Service'),
                                      "time": DateTime.now(),

                                    });
                                    Navigator.pushNamed(context, mapnav.id);
                                  } else {
                                    if (data.get('state') == 'Request') {
                                      rArea=currentArea;

                                      data.data();
                                      details=data;

                                      Navigator.pushNamed(context, info.id);
                                    } else {
                                      createAlert(context);
                                    }
                                  }
                                },
                                splashColor: Colors.redAccent,
                              )],)

                          ],
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }

}

  //data.reference.update({'state': 'Busy'});

