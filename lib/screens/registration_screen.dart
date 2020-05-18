import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/widgets/re_lo_button.dart';
import 'package:flash_chat/widgets/text_field_but_simpler.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = "registration_screen";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;

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
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
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
                keyboard: TextInputType.visiblePassword,
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
                text: 'Registrar',
                color: Colors.blueAccent,
                action: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final new_user = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (new_user != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                        showSpinner = false;
                    });
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
