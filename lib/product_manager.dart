import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:geolocator/geolocator.dart';

import 'package:carousel/carousel.dart';
import './components//animated_fab.dart';
import './products.dart';
import 'containers/nearby_weather.dart';
import 'containers/forecast.dart';
import './components/text_comp.dart';
import './utils//Config.dart';

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
    //Devices
    getCurrentWeather();
    //Simulator
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

  void getCurrentWeather() async {
    getCurrentWeatherWithLatLng('30.424', '76.4343').then((res) {
      this.setState(() {
        _products = res;
      });
    });
    return;

    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
    getCurrentWeatherWithLatLng(
            position.latitude.toString(), position.longitude.toString())
        .then((res) {
      this.setState(() {
        _products = res;
      });
    });
    var geolocator = Geolocator();
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
    String lat = '', lng = '';

    StreamSubscription<Position> positionStream = await geolocator
        .getPositionStream(locationOptions)
        .listen((Position _position) {
      if (_position != null) {
        lat = _position.latitude.toString();
        lng = _position.longitude.toString();
        getCurrentWeatherWithLatLng(lat, lng).then((res) {
          this.setState(() {
            _products = res;
          });
        });
      } else {
        lat = '30.0000';
        lng = '76.89889';
      }
    });
  }

  Future<Map<String, dynamic>> getCurrentWeatherWithLatLng(
      String lat, String lng) async {
    print("inside function");
    Map<String, dynamic> data;
    var url = Config.CURRENT_WEATHER +
        "lat=" +
        lat +
        "&lon=" +
        lng +
        "&appid=" +
        _apiKey +
        '&units=metric';
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
      MaterialPageRoute(builder: (context) => WeatherForecast(cityId: '524901')),
    );
    if (showOnlyCompleted) {
    } else {}
  }

  Widget showWeatherForecast() {
    return SizedBox(
      height: 500.0,
      child: Carousel(
        animationCurve: Curves.ease,
        children: [
          NetworkImage(
              'https://pbs.twimg.com/profile_images/760249570085314560/yCrkrbl3_400x400.jpg'),
          NetworkImage(
              'https://webinerds.com/app/uploads/2017/11/d49396_d9c5d967608d4bc1bcf09c9574eb67c9-mv2.png')
        ]
            .map((bgImg) => new Image(
                image: bgImg,
                width: MediaQuery.of(context).size.width - 100,
                height: 200.0,
                fit: BoxFit.cover))
            .toList(),
        displayDuration: const Duration(seconds: 3),
      ),
    );
  }
}
