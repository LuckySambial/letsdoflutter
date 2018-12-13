import 'package:flutter/material.dart';

import './home.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    onLoginClick() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('Login Screen'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Text("I am Login Screen"),
              Container(
                child: RaisedButton(
                  onPressed: () {
                    onLoginClick();
                  },
                  child: Text('Login'),
                ),
              )
            ],
          ),
        ),
    );
  }
}
