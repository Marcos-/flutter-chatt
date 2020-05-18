import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';

import 'screens/chat_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData.dark().copyWith(
      //   textTheme: TextTheme(
      //     body1: TextStyle(color: Colors.black54),
      //   ),
      // ),
      initialRoute: WelcomeScreen.id,
      routes: <String, WidgetBuilder>{
        WelcomeScreen.id: (BuildContext) => WelcomeScreen(),
        LoginScreen.id: (BuildContext) => LoginScreen(),
        RegistrationScreen.id: (BuildContext) => RegistrationScreen(),
        ChatScreen.id: (BuildContext) => ChatScreen(),
      },
    );
  }
}
