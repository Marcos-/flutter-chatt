import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/widgets/re_lo_button.dart';
import 'package:flash_chat/widgets/text_field_but_simpler.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static String id = "login_screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;

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
        Navigator.pushNamed(context, ChatScreen.id);
      }
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextFieldButSimpler(
                keyboard: TextInputType.emailAddress,
                callBack: (value) {
                  email = value;
                },
                hint: 'Insira seu email',
                color: Colors.grey,
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFieldButSimpler(
                obscure: true,
                callBack: (value) {
                  password = value;
                },
                hint: 'Insira sua senha',
                color: Colors.grey,
              ),
              SizedBox(
                height: 24.0,
              ),
              ReLoButton(
                text: 'Log In',
                action: () async {
                  try {
                    setState(() {
                      showSpinner = true;
                    });
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      setState(() {
                        showSpinner = false;
                      });
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
