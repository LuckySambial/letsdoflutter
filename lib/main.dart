import 'package:flutter/material.dart';

import './containers/login.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
        primaryColor: Colors.purple,
        accentColor: Colors.white,
      ),
   home: Login(),
));


