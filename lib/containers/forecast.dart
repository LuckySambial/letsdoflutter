import 'package:flutter/material.dart';

import 'package:carousel/carousel.dart';
import '../utils/Config.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import '../components/text_comp.dart';
import 'package:intl/intl.dart';

class WeatherForecast extends StatefulWidget {
  String cityId;
  WeatherForecast({this.cityId});
  @override
  State<StatefulWidget> createState() {
    return WeatherForecastState();
  }
}

class WeatherForecastState extends State<WeatherForecast> {
  List<WeatherCast> finalData = [];
  @override
  void initState() {
    fetchWeatherForecastData(widget.cityId).then((response) {
      setState(() {
        finalData = response;
      });
    }).catchError((onError) {
      print("API Error " + onError.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Forecast!'),
        backgroundColor: Color(0xFFB4C56C).withOpacity(0.7),
      ),
      body: Container(
        child: SizedBox(
          height: 500.0,
          child: finalData.length > 0
              ? displayCrausal()
              : Image(image: new AssetImage("assets/loader.gif")),
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

  Widget displayCrausal() {
    return Carousel(
      animationCurve: Curves.ease,
      children: finalData
          .map((item) => Card(
                color: Color(0xFFB4C56C).withOpacity(0.7),
                child: Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: MediaQuery.of(context).size.height - 300,
                  child: Column(
                    children: <Widget>[
                      TextComp(
                          text: new DateFormat.jm()
                              .format(DateTime.parse(item.rawDate)),
                          fontSize: 25.0),
                      Container(
                        width: 120,
                        height: 120,
                        child: Image.network(
                            'https://openweathermap.org/img/w/' +
                                item.icon +
                                '.png',
                            fit: BoxFit.cover),
                      ),
                      TextComp(
                          text: item.temp.toInt().toString() + '°',
                          fontSize: 40.0),
                      TextComp(text: item.main, fontSize: 25.0),
                      TextComp(text: item.description, fontSize: 15.0),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                    child: TextComp(
                                        text: item.minTemp.toInt().toString(),
                                        fontSize: 25.0),
                                  ),
                                  TextComp(text: 'Min Temp', fontSize: 12.0),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                    child: TextComp(
                                        text: item.maxTemp.toInt().toString(),
                                        fontSize: 25.0),
                                  ),
                                  TextComp(text: 'Max Temp', fontSize: 12.0),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ))
          .toList(),
      displayDuration: const Duration(seconds: 5),
    );
  }
}

class WeatherCast {
  final double temp;
  final String icon;
  final double minTemp;
  final double maxTemp;
  final double pressure;
  final int humidity;
  final String main;
  final String description;
  final String rawDate;
  WeatherCast(
      {this.temp,
      this.icon,
      this.minTemp,
      this.maxTemp,
      this.pressure,
      this.humidity,
      this.main,
      this.description,
      this.rawDate});
}
