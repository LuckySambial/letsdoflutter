import 'package:flutter/material.dart';

import './containers/welcom_screen.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
        primaryColor: Colors.purple,
        accentColor: Colors.white,
      ),
   home: WelcomScreen(),
));


