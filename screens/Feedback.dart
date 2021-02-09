import 'package:flutter/material.dart';
import 'package:myfinal/components/validator.dart';
import 'package:myfinal/screens/Rate.dart';
import '../components/Location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
String _rate;
String nameFeed;
class feedback extends StatefulWidget {
  static String id = 'feedback';
  createState() {
    return RateState();
  }
}
class RateState extends State<feedback>{
  createAlert(BuildContext context){
    return showDialog(context: context,builder: (context){
      return AlertDialog(title: Text('Thank You'),actions: <Widget>[MaterialButton(child: Text('ok'),onPressed: (){Navigator.of(context).pop();})],);
    });
  }
  final  _fireStore = FirebaseFirestore.instance;
  final formKey = GlobalKey<FormState>();
  Widget build(context) {
    return Scaffold(body:Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),child:  Container(
      margin: EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            RateField(),
            Container(margin: EdgeInsets.only(top: 25)),
            sumbitButtion(),
          ],
        ),
      ),
    ),),);

  }

  Widget RateField() {
    return TextFormField(

      decoration: InputDecoration(
          labelText: 'Rate From 1 to 10'),
      // ignore: missing_return
      validator: validateRate,
      onSaved: (value) {
        _rate = value ;
      },
    );
  }

  Widget sumbitButtion() {
    return RaisedButton(
      color: Colors.blue[200],
      child: Text("Sumbit Rate"),
      onPressed: () {
        getLocation();
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          if(lat!=null&&long!=null) {
            _fireStore.collection('Feedback').add({
              "Name":nameFeed,
              "Rate": _rate,
              "long":long,
              "lat":lat,
              "time": DateTime.now(),
            });
          }
          else{getLocation();_fireStore.collection('Feedback').add({
            "Name":nameFeed,
            "Rate": rate,
            "long":long,
            "lat":lat,
          });
          }
          createAlert(context);

        }


      },
    );
  }
}
