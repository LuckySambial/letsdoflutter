import 'package:flutter/material.dart';

import './product_manager.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
        primaryColor: Colors.purple,
        accentColor: Colors.white,
      ),
      home: ProductManager(),
));

