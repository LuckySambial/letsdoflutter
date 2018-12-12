import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final products;
  Products(this.products);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        // Image.asset('assets/c2.jpg'),
        Text(products != null ? products["main"]: 'Oops!')
      ],
    );
  }
}
