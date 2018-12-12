import 'package:flutter/material.dart';
import 'dart:convert';

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
        Text(weather['main']),
        Image.network(
            'https://openweathermap.org/img/w/' + weather['icon'] + '.png'),
        Text(products['name']),
        Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('Temprature: '),
                    Container(
                      margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
                      color: Colors.pink,
                      child: Text(mainWeather['temp'].toString()),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('humidity: '),
                    Container(
                      margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
                      color: Colors.pink,
                      child: Text(mainWeather['humidity'].toString()),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('Min Temp: '),
                    Container(
                      margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
                      color: Colors.pink,
                      child: Text(mainWeather['temp_min'].toString()),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('Max Temp: '),
                    Container(
                      margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
                      color: Colors.pink,
                      child: Text(mainWeather['temp_min'].toString()),
                    )
                  ],
                ),
              ],
            )),
      ],
    );
  }
}
