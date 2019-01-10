import 'package:flutter/material.dart';

class TextComp extends StatelessWidget {
  String text = 'N/A';
  TextStyle textStyle;
  var fontSize;
  var width;
  TextComp({this.text, this.fontSize = 20.0, this.width});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
      width: width,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
