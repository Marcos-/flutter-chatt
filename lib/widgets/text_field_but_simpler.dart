import 'package:flutter/material.dart';

class TextFieldButSimpler extends StatelessWidget {
  final TextInputType keyboard;
  final bool obscure;
  final Color color;
  final String hint;
  final Function callBack;
  const TextFieldButSimpler({
    Key key, this.color, this.hint, this.callBack, this.obscure  = false, this.keyboard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboard,
      obscureText: obscure,
      textAlign: TextAlign.center,
      style: TextStyle(color: color),
      onChanged: callBack,
      decoration: InputDecoration(
        hintStyle: TextStyle(
          color: color,
        ),
        hintText: hint,
        contentPadding:
            EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.lightBlueAccent, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.lightBlueAccent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
    );
  }
}