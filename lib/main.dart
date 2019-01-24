import 'package:flutter/material.dart';

import './product_manager.dart';
import './containers/welcom_screen.dart';
import './containers/splash.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(
        fontFamily: 'Raleway',
        primaryColor: Colors.purple,
        accentColor: Colors.white,
      ),
      home: Splash(),
    ));
