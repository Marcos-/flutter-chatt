import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseUser loggedInUser;

class ChatScreen extends StatefulWidget {
  static String id = "chat_screen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  String messageText;
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async{
    try{
      final user = await _auth.currentUser();
      if (user != null){
        loggedInUser = user;
        print(loggedInUser.email);
      }
    }catch(e){
      print(e);
    }
  }

  void getMessages() async {
    final messages = await _firestore.collection("messages").getDocuments();
    for (var message in messages.documents){
      print(message.data);
    }
  }

    void messageStream() async {
    await for(var snapshots in _firestore.collection("messages").snapshots()){
      for (var message in snapshots.documents){
        print(message.data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(firestore: _firestore),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      _firestore.collection("messages").add({
                        'text': messageText,
                        'sender': loggedInUser.email,
                      });
                      messageTextController.clear();
                    },
                    child: Text(
                      'Enviar',
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
  const MessageStream({
    Key key,
    @required Firestore firestore,
  }) : _firestore = firestore, super(key: key);

  final Firestore _firestore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection("messages").snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        }else{
          final messages = snapshot.data.documents.reversed;
          List<MessageBubble> messageBubbles = [];
          for (var message in messages){

            final messageBubble = MessageBubble(
              sender: message.data['sender'],
              text: message.data['text'],
              isMe: loggedInUser.email == message.data['sender'],
            );
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: messageBubbles,
            )
          );
        }
      }
    );
  }
}

class MessageBubble extends StatelessWidget{
  final String sender;
  final String text;
  final bool isMe;

  MessageBubble({this.sender, this.text, this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment,
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "$sender:",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          Material(
            elevation: 3,
            color: isMe ? Colors.lightBlue[50] : Colors.white,
            borderRadius: BorderRadius.circular(25),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                '$text from $sender',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  

}