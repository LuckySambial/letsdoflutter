import 'package:flutter/material.dart';

import '../components/text_comp.dart';
import '../containers/tab_navigator.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TabNavigator()),
        );
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Image(
          image: AssetImage("assets/splash.gif"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
