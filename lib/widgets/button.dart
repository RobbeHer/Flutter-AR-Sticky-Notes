import 'package:flutter/material.dart';

typedef void MyCallBack();

class ButtonWidget extends StatelessWidget {
  final MyCallBack onButtonPressed;
  final String text;

  ButtonWidget({this.text, this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        onButtonPressed();
      },
      child: Text(
        text,
        style: TextStyle(
          fontFamily: "JosefinSans",
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
