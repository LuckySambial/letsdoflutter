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
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.purple[400],
            Colors.purple[600],
            Colors.purple[800],
            Colors.purple[900],
          ],
        ),
      ),
      child: Column(
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
                });
              },
              child: TextComp(text: 'Refresh Weather!',),
            ),
          ),
          checkForProducts(_products),
          Container(
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              onPressed: () => nearbyWeather(),
              child: TextComp(text:'Nearby Me Weather!'),
            ),
          )
        ],
      ),
    );
  }

  Widget checkForProducts(products) {
    if (_products != null) {
      return Products(products);
    } else {
      return TextComp(text:'Loading!!!');
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
    Navigator.push(context, MaterialPageRoute(builder: (context)=> NearByWeather()));
  }
}
