import 'package:flutter/material.dart';
import 'package:myfinal/components/validator.dart';
import 'display.dart';
import '../components/Location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
double rateee;
String rateService;
double avg;
class rate extends StatefulWidget {
  static String id = 'rate';
  createState() {
    return RateState();
  }
}
class RateState extends State<rate>{
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
          labelText: 'Rate From 1 to 5'),
      // ignore: missing_return
      validator: validateRate,
      onSaved: (value) {
        rateService = value;
        rateee=double.parse(rateService);
      },
    );
  }

  Widget sumbitButtion() {
    return RaisedButton(
      color: Colors.blue[200],
      child: Text("Sumbit Rate"),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          avg=double.parse(details.get('Rate'));
          avg=rateee+avg/2;
          rateService=avg.toString();
          details.reference.update({'Rate': '$rateService'});
          createAlert(context);

        }


      },
    );
  }
}
