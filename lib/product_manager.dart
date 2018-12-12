import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import './products.dart';

class ProductManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  Map<String, dynamic> _products;
  String _apiKey = '47ee9f58572d02786966d718ee8292cb';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(20),
          child: RaisedButton(
            color: Theme.of(context).primaryColor,
            onPressed: () {
              getCurrentWeather().then((res) {
                this.setState(() {
                  _products = res;
                });
                print('Success ' + _products.toString());
              });
            },
            child: Text(
              'Check your City Weather!',
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
          ),
        ),
        checkForProducts(_products),
      ],
    );
  }

  Widget checkForProducts(products) {
    if (_products != null) {
      return Products(products);
    } else {
      return Text('Oops!!!');
    }
  }

  Future<Map<String, dynamic>> getCurrentWeather() async {
    Map<String, dynamic> data;
    var url =
        "https://openweathermap.org/data/2.5/weather?lat=30.444&lon=76.444&appid=b6907d289e10d714a6e88b30761fae22";
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.OK) {
      var jsonString = await response.transform(utf8.decoder).join();
      data = json.decode(jsonString);
      return data;
    } else {
      return data;
    }
  }
}
