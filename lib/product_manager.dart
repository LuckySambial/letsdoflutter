import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_fab_dialer/flutter_fab_dialer.dart';
import 'package:flutter/services.dart';
import './components/guillotineMenu.dart';
import 'package:intl/intl.dart';

import 'package:carousel/carousel.dart';
import './components//animated_fab.dart';
import './products.dart';
import 'containers/nearby_weather.dart';
import 'containers/forecast.dart';
import './components/text_comp.dart';
import './utils//Config.dart';
import './utils/Colors.dart';

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
  final String cityId = '';
  List<WeatherCast> forecastData = [];

  @override
  void initState() {
    getCurrentWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: viewContainer,
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
        fetchWeatherForecastData(res['id'].toString()).then((response) {
          setState(() {
            _products = res;
            forecastData = response;
          });
        }).catchError((onError) {
          print("API Error " + onError.toString());
        });
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
      print(data.toString());
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
      MaterialPageRoute(builder: (context) => NearByWeather()),
    );
    if (showOnlyCompleted) {
    } else {}
  }

  Widget viewContainer(BuildContext context, BoxConstraints boxconstraints) {
    return Stack(
      children: <Widget>[
        _backView(context),
        GuillotineMenu(
            currentCityId:
                _products != null ? _products['id'].toString() : null,
            currentCityName: _products != null ? _products['name'] : null),
      ],
    );
  }

  Widget _backView(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent, //or set color with: Color(0xFF0000FF)
    ));
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 15),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Color(AppColors.PRIMARY_COLOR).withOpacity(0.9),
            Color(AppColors.PRIMARY_COLOR).withOpacity(0.8),
            Color(AppColors.PRIMARY_COLOR).withOpacity(0.7),
            Color(AppColors.PRIMARY_COLOR).withOpacity(0.6),
          ],
        )),
        child: Container(
          child: Stack(
            alignment: Alignment.center,
            children: [
              checkForProducts(_products),
              // _buildFab(),
              // _buildForecastCrausal(),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<WeatherCast>> fetchWeatherForecastData(cityId) async {
    List<WeatherCast> dataList = <WeatherCast>[];
    String url = Config.WEATHER_FORECAST +
        'id=' +
        cityId +
        '&appid=47ee9f58572d02786966d718ee8292cb&units=metric';
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.OK) {
      var jsonString = await response.transform(utf8.decoder).join();
      var data = json.decode(jsonString);
      for (Map<String, dynamic> item in data['list']) {
        Map<String, dynamic> mainWeather = item['main'];
        var waetherArray = item['weather'];
        Map<String, dynamic> weatherDetails = waetherArray[0];
        dataList.add(new WeatherCast(
          temp: mainWeather['temp'],
          minTemp: mainWeather['temp_min'],
          maxTemp: mainWeather['temp_max'],
          pressure: mainWeather['pressure'],
          humidity: mainWeather['humidity'],
          icon: weatherDetails['icon'],
          main: weatherDetails['main'],
          description: weatherDetails['description'],
          rawDate: item['dt_txt'],
        ));
      }
      return dataList;
    } else {
      return dataList;
    }
  }

  Widget _buildForecastCrausal() {
    return Container(
      margin: EdgeInsets.only(top: 400),
      child: SizedBox(
        height: 200.0,
        child: forecastData.length > 0
            ? displayCrausal()
            : Image(image: new AssetImage("assets/loader.gif")),
      ),
    );
  }

  Widget displayCrausal() {
    return Carousel(
      animationCurve: Curves.easeInOut,
      children: forecastData
          .map((item) => Container(
                decoration: BoxDecoration(
                  color: Color(AppColors.SECONDARY_COLOR).withOpacity(0.9),
                  borderRadius: BorderRadius.all(Radius.circular(100.0)),
                ),
                padding: EdgeInsets.all(20.0),
                width: MediaQuery.of(context).size.width - 150,
                height: MediaQuery.of(context).size.height - 480,
                child: Column(
                  children: <Widget>[
                    TextComp(
                        text: new DateFormat.jm()
                            .format(DateTime.parse(item.rawDate)),
                        fontSize: 25.0),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                child: TextComp(
                                    text: item.minTemp.toInt().toString(),
                                    fontSize: 25.0),
                              ),
                              TextComp(text: 'Min', fontSize: 12.0),
                            ],
                          ),
                          Container(
                            width: 60,
                            height: 60,
                            child: Image.network(
                                'https://openweathermap.org/img/w/' +
                                    item.icon +
                                    '.png',
                                fit: BoxFit.cover),
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                child: TextComp(
                                    text: item.maxTemp.toInt().toString(),
                                    fontSize: 25.0),
                              ),
                              TextComp(text: 'Max', fontSize: 12.0),
                            ],
                          )
                        ]),
                    TextComp(text: item.main, fontSize: 25.0),
                  ],
                ),
              ))
          .toList(),
      displayDuration: const Duration(seconds: 2),
    );
  }
}
