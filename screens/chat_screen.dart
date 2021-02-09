import 'package:flutter/material.dart';
import 'package:myfinal/components/Location.dart';
import 'package:myfinal/components/rounded_button.dart';
import 'package:myfinal/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/display.dart';
import '../components/user.dart';
import 'map.dart';
final _firestore = FirebaseFirestore.instance;
DocumentSnapshot provider;
String currentUser;
double navlat,navlong;
int Ofcolor=0xFFD50000;
int Ocolor=0xFF1B5E20;
int stateColor=0xFF1B5E20;
bool click=false;
String Online='Your Are Online';
String Offline='You Are Offline';
bool acc=false;
String StateType=Online;
class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String messagesText;


  void initState() {
    super.initState();
    getCurrentUser();
  }


  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        // loggedInUser=user;
        currentUser = user.email;


      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          RoundedButton(
            title: StateType,
            color: Color(stateColor),
              onPressed: () async{
setState(() {

});
                if(click==false)
                  {
                    stateColor=Ocolor;
                    StateType=Online;
                    click=true;
                    await _firestore.collection('provider').doc('$currentUser').update({'state': 'Request'});

                  }

                else{
                  stateColor=Ofcolor;
                  StateType=Offline;
                  click=false;
                  await _firestore.collection('provider').doc('$currentUser').update({'state': 'Busy'});

                }



              }),
        ],
        title: Text("Requests"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messagesText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextController.clear();
                      final user = _auth.currentUser;
                      // _firestore.collection('messages').add({
                      //
                      //   'text': messagesText,
                      //   'sender': user.email,
                      //   "time": DateTime.now(),
                      //
                      // });
                      //

                      //Implement send functionality.
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('provider').doc('$currentUser').collection('Request').orderBy('time', descending: false).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          final messages = snapshot.data.docs.reversed;
          List<MessageBubble> messageBubbles = [];
          for (var message in messages) {
            final messageSender = message.data()['name'];
            final mobileSender = message.data()['mobile'];
            final latcar=message.data()['lat'];
            final longcar=message.data()['long'];
            navlat=latcar;
            navlong=longcar;
            final messageTime = message.data()['time'] as Timestamp;
            final messageBubble = MessageBubble(
              sender: messageSender,
              mobile: mobileSender,
              isMe: currentUser == messageSender,
              time: messageTime,

            );
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse:true,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: messageBubbles,
            ),
          );
        }
        //},
        );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender,this.mobile, this.isMe,this.time});
  final String sender;
  final String mobile;
  final bool isMe;
  final Timestamp time;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: <Widget>[
          MaterialButton(color: Colors.red,onPressed: null),
          Text(
            sender,
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          Text(
            mobile,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          Material(
            borderRadius: isMe?BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)):BorderRadius.only(  bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),topRight: Radius.circular(30),
            ),
            elevation: 5,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text('I need help',
                style: TextStyle(
                  fontSize: 15,
                  color: isMe?Colors.white:Colors.black54,
                ),
              ),
            ),
          ),
          RaisedButton(child:Text('Accept'),color: Colors.blue,onPressed: (){

            _firestore.collection('provider').doc('$currentUser').update({'state': 'Busy'});
            latFrom=lat;
            longFrom=long;
            latTo=navlat;
            longTo=navlong;
            print(longFrom);
            Navigator.pushNamed(context, mapnav.id);

          }),
          SizedBox(height: 10,),
          RaisedButton(child:Text('Reject'),color: Colors.blue,onPressed: (){
            _firestore.collection('provider').doc('$currentUser').collection('Request').doc().delete();
          }),
          SizedBox(height: 10,),
          RaisedButton(child:Text('Show'),color: Colors.blue,onPressed: (){getLocation();
          getLocation();
          latFrom=lat;
          longFrom=long;
          latTo=navlat;
          longTo=navlong;
          currentUsermap=currentUser;
          if(latFrom!=null&&longFrom!=null&&latTo!=null&&longTo!=null) {
            Navigator.pushNamed(context, mapnav.id);
          }
          else
            {getLocation();
            latFrom=lat;
            longFrom=long;
            latTo=navlat;
            longTo=navlong;
            Navigator.pushNamed(context, mapnav.id);
            }
          })
        ],
      ),
    );
  }
}
