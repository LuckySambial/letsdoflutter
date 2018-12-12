import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import './products.dart';

class ProductManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  List<String> _products = ['Food Tester'];
  String _apiKey = '47ee9f58572d02786966d718ee8292cb';

  String response;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(20),
          child: RaisedButton(
            color: Colors.blue,
            onPressed: () {
              getCurrentWeather().then((res) {
                this.setState(() {
                  response = res;
                });
                print('Success ' + res);
              });
            },
            child: Text('Click Me'),
          ),
        ),
        Products(response != null ? json.decode(response) : null),
      ],
    );
  }

  Future<String> getCurrentWeather() async {
    var data;
    var url ="https://openweathermap.org/data/2.5/weather?lat=30.444&lon=76.444&appid=b6907d289e10d714a6e88b30761fae22";
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.OK) {
      var jsonString = await response.transform(utf8.decoder).join();
      data = json.decode(jsonString);
      return jsonString.toString();
    } else {
      return data.toString();
    }
  }
}
