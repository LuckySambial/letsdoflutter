import 'package:flutter/material.dart';
import 'dart:convert';

import './components/text_comp.dart';

class Products extends StatelessWidget {
  final Map<String, dynamic> products;
  Products(this.products);
  @override
  Widget build(BuildContext context) {
    var weather = products['weather'][0];
    Map<String, dynamic> mainWeather = products['main'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  TextComp(
                      text: mainWeather['temp'].toString() + '°',
                      fontSize: 60.0),
                  TextComp(text: weather['main'], fontSize: 25.0),
                  TextComp(text: products['name'], fontSize: 15.0),
                ],
              ),
              Container(
                width: 150,
                height: 150,
                child: Image.network(
                    'https://openweathermap.org/img/w/' +
                        weather['icon'] +
                        '.png',
                    fit: BoxFit.cover),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFB4C56C).withOpacity(0.3),
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
          ),
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.wifi_tethering, size: 40, color: Colors.white),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: TextComp(text: mainWeather['temp'].toString()),
                    ),
                    TextComp(text: 'Temprature', fontSize: 12.0),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.wb_incandescent, size: 40, color: Colors.white),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: TextComp(text: mainWeather['humidity'].toString()),
                    ),
                    TextComp(text: 'humidity', fontSize: 12.0),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.cloud_circle, size: 40, color: Colors.white),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: TextComp(text: mainWeather['temp_min'].toString()),
                    ),
                    TextComp(text: 'Min Temp', fontSize: 12.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
