import 'package:flash_chat/widgets/re_lo_button.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'login_screen.dart';
import 'registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = "welcome_screen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation animation;

  @override
  void initState(){
    super.initState();
    
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
      upperBound: 100.0,
    );

    controller.forward();

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.decelerate,
    );

    controller.addListener(() {
      setState(() {
        controller.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 70.0,//controller.value,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  isRepeatingAnimation: true,
                  speed: Duration(milliseconds: 300),
                  text: ['Flash Chat'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            ReLoButton(text: 'Log In', action: (){Navigator.pushNamed(context, LoginScreen.id);}, color: Colors.lightBlueAccent,),
            ReLoButton(text: 'Registrar', action: (){Navigator.pushNamed(context, RegistrationScreen.id);}, color: Colors.blueAccent),
          ],
        ),
      ),
    );
  }
}
