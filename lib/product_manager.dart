import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import './products.dart';
import 'containers/nearby_weather.dart';
import './components/text_comp.dart';

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
  void initState() {
    getCurrentWeather().then((res) {
      this.setState(() {
        _products = res;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      decoration: BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("assets/house_bg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Column(
          children: [
            checkForProducts(_products),
          ],
        ),
      ),
    );
  }

  Widget checkForProducts(products) {
    if (_products != null) {
      return Products(products);
    } else {
      return Image(image: new AssetImage("assets/loader.gif"));
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

  nearbyWeather() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NearByWeather()));
  }
}
