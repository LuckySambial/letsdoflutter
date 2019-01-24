import 'package:flutter/material.dart';

import '../product_manager.dart';
import './tab_navigator.dart';
class WelcomScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new WelcomeScreenState();
  }
}

class WelcomeScreenState extends State<WelcomScreen> {
  String email = '';
  String passowrd = '';

  @override
  void initState() {
    super.initState();
  }
  onChangeText(text, key) {
    switch (key) {
      case 'Email':
        setState(() {
          email = text.trim();
        });
        break;
      case 'Password':
        setState(() {
          passowrd = text;
        });
        break;
      default:
    }
  }
  @override
  Widget build(BuildContext context) {
    onLoginClick() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TabNavigator()),
      );
    }
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.purple[400],
          Colors.purple[600],
          Colors.purple[800],
          Colors.purple[900],
        ])),
        child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
                  child: Image.asset('assets/app_icon.png'),
                ),
                TextInputComp(
                    onChangeText: onChangeText,
                    hintText: 'Email',
                    isPass: false),
                TextInputComp(
                    onChangeText: onChangeText,
                    hintText: 'Password',
                    isPass: true),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: OutlineButton(
                    onPressed: () {
                      onLoginClick();
                    },
                    child: Text('Login'),
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}

class TextInputComp extends StatelessWidget {
  String hintText = '';
  bool isPass = false;
  Function onChangeText;
  TextInputComp({this.onChangeText, this.hintText, this.isPass});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              side: BorderSide(color: Color(0xffDDE9E8), width: 2.5))),
      child: TextField(
        keyboardType: (!isPass ? TextInputType.emailAddress : null),
        obscureText: isPass,
        onChanged: (text) => onChangeText(text, hintText),
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
            hintStyle: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
            hintText: hintText),
      ),
    );
  }
}
