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
    Map<String, dynamic> wind = products['wind'];

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
                      text: mainWeather['temp'].toInt().toString() + '°',
                      fontSize: 60.0),
                  TextComp(text: weather['main'], fontSize: 25.0),
                  TextComp(text: products['name'], fontSize: 15.0),
                ],
              ),
              Container(
                width: 120,
                height: 120,
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
          margin: EdgeInsets.fromLTRB(10, 70, 10, 10),
          padding: EdgeInsets.fromLTRB(30, 20, 20, 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.wifi_tethering, size: 40, color: Colors.white),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: TextComp(text: mainWeather['pressure'].toInt().toString()+'hpa', fontSize: 14.0),
                    ),
                    TextComp(text: 'Air Pessure', fontSize: 12.0),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.wb_incandescent, size: 40, color: Colors.white),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: TextComp(text: mainWeather['humidity'].toString()+'%', fontSize: 14.0),
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
                      child: TextComp(text: wind['speed'].toString()+'km/h', fontSize: 14.0),
                    ),
                    TextComp(text: 'Wind', fontSize: 12.0),
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
