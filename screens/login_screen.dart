import 'package:myfinal/screens/Service.dart';
import 'package:myfinal/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:myfinal/components/rounded_button.dart';
import 'package:myfinal/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner=false;
  final FirebaseAuth _auth=FirebaseAuth.instance;
  String _emailCar;
  String _passwordCar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                 _emailCar=value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter Your Email'),
              ),
              SizedBox(
                height: 5.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  _passwordCar=value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter Your Password'),
              ),

              RoundedButton(
                title: 'Log In',
                color: Colors.lightBlueAccent,
                onPressed: () async{
                  setState(() {
                   showSpinner=true;
                  });

                try {

                  final carOwner=await _auth.signInWithEmailAndPassword(email: _emailCar, password: _passwordCar);
                  if(carOwner !=null)
                    {
                      Navigator.pushNamed(context, ServicePage.id);
                    }
                  setState(() {
                    showSpinner=false;
                  });

                }
                catch (e){
                  print(e);
                }
                  },
              )
            ],
          ),
        ),

    );
  }
}
