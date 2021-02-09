import 'package:myfinal/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:myfinal/components/rounded_button.dart';
import 'package:myfinal/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
class LoginProvider extends StatefulWidget {
  static String id = 'login_screen_provider';
  @override
  _LoginProviderState createState() => _LoginProviderState();
}

class _LoginProviderState extends State<LoginProvider> {
  bool showSpinner=false;
  final FirebaseAuth _auth=FirebaseAuth.instance;
  String _email;
  String _password;

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
                _email=value;
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
                _password=value;
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
                  final user = await _auth.signInWithEmailAndPassword(
                      email: _email, password: _password);
                  if (user != null) {
                    Navigator.pushNamed(context, ChatScreen.id);
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
