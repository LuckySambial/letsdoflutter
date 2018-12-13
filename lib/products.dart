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
      children: <Widget>[
        //Image.asset('assets/c2.jpg'),
        TextComp(text: weather['main'], fontSize: 30.0),
        Container(
          width: 100,
          height: 100,
          child: Image.network(
            'https://openweathermap.org/img/w/' + weather['icon'] + '.png',
          fit: BoxFit.cover
          ),
        ),
        TextComp(text: products['name'], fontSize: 30.0),
        Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    TextComp(text: 'Temprature: '),
                    TextComp(text: mainWeather['temp'].toString()),
                  ],
                ),
                Row(
                  children: <Widget>[
                    TextComp(text: 'humidity: '),
                    TextComp(text: mainWeather['humidity'].toString()),
                  ],
                ),
                Row(
                  children: <Widget>[
                    TextComp(text: 'Min Temp: '),
                    TextComp(text: mainWeather['temp_min'].toString()),
                  ],
                ),
                Row(
                  children: <Widget>[
                    TextComp(text: 'Max Temp: '),
                    TextComp(text: mainWeather['temp_min'].toString()),
                  ],
                ),
              ],
            )),
      ],
    );
  }
}
