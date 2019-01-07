import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:geolocator/geolocator.dart';

import './components//animated_fab.dart';
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
  bool showOnlyCompleted = false;
  final double _imageHeight = 10.0;

  @override
  void initState() {
    getCurrentWeatherWithLatLng('30.7046',"76.7179").then((res) {
      this.setState(() {
        _products = res;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/house_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: Stack(
            children: [
              checkForProducts(_products),
              _buildFab(),
            ],
          ),
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
    var geolocator = Geolocator();
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
    String lat = '', lng = '';

    StreamSubscription<Position> positionStream = await geolocator
        .getPositionStream(locationOptions)
        .listen((Position _position) {
    print("inside function");
      if (_position != null) {
        lat = _position.latitude.toString();
        lng = _position.longitude.toString();
        return getCurrentWeatherWithLatLng(lat, lng);
      } else {
        lat = '30.0000';
        lng = '76.89889';
        return getCurrentWeatherWithLatLng(lat, lng);
      }
    });
  }

  Future<Map<String, dynamic>> getCurrentWeatherWithLatLng(String lat, String lng) async{
    print("inside function");
    Map<String, dynamic> data;
    var url = "https://openweathermap.org/data/2.5/weather?lat=" +
        lat +
        "&lon=" +
        lng +
        "&appid=b6907d289e10d714a6e88b30761fae22";
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

  Widget _buildFab() {
    return Positioned(
        bottom: 10.0,
        right: -40.0,
        child: AnimatedFab(
          onClick: _changeFilterState,
        ));
  }

  _changeFilterState() {
    showOnlyCompleted = !showOnlyCompleted;
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NearByWeather()),
      );
    if (showOnlyCompleted) {
    } else {}
  }
}
