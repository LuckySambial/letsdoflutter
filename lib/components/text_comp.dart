import 'package:flutter/material.dart';

class TextComp extends StatelessWidget {
  String text = 'N/A';
  TextStyle textStyle;
  var fontSize;
  TextComp({this.text, this.fontSize = 20.0});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
