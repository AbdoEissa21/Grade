import 'package:flutter/material.dart';
import 'package:myfinal/components/validator.dart';
import 'display.dart';
import '../components/Location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class info extends StatefulWidget {
  static String id = 'info';
  createState() {
    return infoState();
  }
}
String rArea;
class infoState extends State<info>{
  createAlert(BuildContext context){
    return showDialog(context: context,builder: (context){
      return AlertDialog(title: Text('Request Sent'),actions: <Widget>[MaterialButton(child: Text('ok'),onPressed: (){Navigator.of(context).pop();})],);
    });
  }
  final  _fireStore = FirebaseFirestore.instance;
  final formKey = GlobalKey<FormState>();
  String _namecar = '';
  String _mobilecar = '';
  String _cartype;
  String _dtails;
  String ar;
   bool done=false;
  Widget build(context) {
    return Scaffold(body:Padding(
    padding: EdgeInsets.symmetric(horizontal: 10.0),child:  Container(
    margin: EdgeInsets.all(20),
    child: Form(
    key: formKey,
    child: Column(
    children: [
   nameField(),
    mobile(),
    CarType(),
    Details(),

    Container(margin: EdgeInsets.only(top: 25)),
    sumbitButtion(),
    ],
    ),
    ),
    ),),);

  }

  Widget nameField() {
    return TextFormField(

      decoration: InputDecoration(
          labelText: 'Name'),
      // ignore: missing_return
      validator: validateName,
      onSaved: (value) {
        _namecar = value;
      },
    );
  }

  Widget mobile() {
    return TextFormField(
      //obscureText: true,
      decoration: InputDecoration(labelText: 'Mobile'),
      // ignore: missing_return
      validator: validateMobile,
      onSaved: (value) {
        _mobilecar = value;
      },
    );
  }
  Widget CarType() {
    return TextFormField(

      //obscureText: true,
      decoration: InputDecoration(labelText: 'CarType (Optional)'),
      // ignore: missing_return

      onSaved: (value) {
        _cartype = value;
      },
    );
  }

  Widget Details() {
    return TextFormField(

      //obscureText: true,
      decoration: InputDecoration(labelText: 'Details about what happen (Optional)'),
      // ignore: missing_return

      onSaved: (value) {
        _dtails = value;
      },
    );
  }
  Widget sumbitButtion() {
    return RaisedButton(
      color: Colors.blue[200],
      child: Text("Sumbit Request"),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          getLocation();
          latCar =  lat;
          longCar = long;
          if(latCar!=null && longCar!=null) {
            _fireStore.collection('Analysis').add({


              'lat': latCar,
              'long': longCar,
              'Area':details.get('Area'),
              'Details':_dtails,
              'Cartype':_cartype,
              'ServiceType':details.get('Service'),
              "time": DateTime.now(),

            }
            );
            details.reference.collection('Request').add({
              'name': _namecar,
              'mobile': _mobilecar,
              'lat': latCar,
              'long': longCar,
              "time": DateTime.now(),
            });
          }
          else {
            getLocation();
            latCar = lat;
            longCar = long;
            if (latCar != null && longCar != null) {
              details.reference.collection('Request').add({
                 'name': _namecar,
                 'mobile': _mobilecar,
                 'lat': latCar,
                 'long': longCar,
                 "time": DateTime.now(),
            });
              // _fireStore.collection('provider').add({
              //
              //   'name': namecar,
              //   'mobile': mobilecar,
              //   'lat': latCar,
              //   'long': longCar,
              //   "time": DateTime.now(),
              //
              // }
              // );

            }
          }
          createAlert(context);
        }

      },
    );
  }
}
