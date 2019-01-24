import 'package:flutter/material.dart';

import '../utils/Colors.dart';

class TextComp extends StatelessWidget {
  String text = 'N/A';
  TextStyle textStyle;
  var fontSize;
  var width;
  var fontWeight;
  var color;
  TextComp(
      {this.text,
      this.color = Colors.white,
      this.fontSize = 20.0,
      this.width,
      this.fontWeight = FontWeight.bold});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
      width: width,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
