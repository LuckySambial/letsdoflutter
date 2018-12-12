import 'package:flutter/material.dart';
import './product_manager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.purple,
        accentColor: Colors.white,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Lets Do It!'),
          ),
          body: ProductManager()),
    );
  }
}
