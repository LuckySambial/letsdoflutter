import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import './utils/Colors.dart';
import './components/text_comp.dart';

class Products extends StatelessWidget {
  final Map<String, dynamic> products;
  Products(this.products);
  @override
  Widget build(BuildContext context) {
    var weather = products['weather'][0];
    var date = products['dt'];
    Map<String, dynamic> mainWeather = products['main'];
    Map<String, dynamic> wind = products['wind'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        width: 80,
                        height: 80,
                        child: Image.network(
                            'https://openweathermap.org/img/w/' +
                                weather['icon'] +
                                '.png',
                            fit: BoxFit.cover),
                      ),
                      TextComp(text: products['name'], fontSize: 35.0),
                    ],
                  ),
                  TextComp(
                      text: new DateFormat.yMMMMEEEEd("en_US").format(
                          DateTime.fromMillisecondsSinceEpoch(date * 1000)),
                      fontSize: 20.0, fontWeight: FontWeight.normal,),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Column(
                      children: <Widget>[
                        TextComp(
                            text: mainWeather['temp'].toInt().toString() + '°c',
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold),
                        TextComp(text: weather['main'], fontSize: 25.0, fontWeight: FontWeight.normal,),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Color(AppColors.SECONDARY_COLOR).withOpacity(0.9),
            borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
          ),
          margin: EdgeInsets.fromLTRB(10, 80, 10, 10),
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
                      child: TextComp(
                          text: mainWeather['pressure'].toInt().toString() +
                              'hpa',
                          fontSize: 14.0),
                    ),
                    TextComp(text: 'Air Pessure', fontSize: 12.0,fontWeight: FontWeight.bold,),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.wb_incandescent, size: 40, color: Colors.white),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: TextComp(
                          text: mainWeather['humidity'].toString() + '%',
                          fontSize: 14.0),
                    ),
                    TextComp(text: 'humidity', fontSize: 12.0, fontWeight: FontWeight.bold),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.cloud_circle, size: 40, color: Colors.white),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: TextComp(
                          text: wind['speed'].toString() + 'km/h',
                          fontSize: 14.0),
                    ),
                    TextComp(text: 'Wind', fontSize: 12.0, fontWeight: FontWeight.bold,),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Container(
        //   margin: EdgeInsets.all(20),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: <Widget>[
        //       Container(
        //         padding: EdgeInsets.all(20),
        //         decoration: BoxDecoration(
        //           color: Color(AppColors.SECONDARY_COLOR).withOpacity(0.8), 
        //           borderRadius: BorderRadius.all(Radius.circular(80)),
        //         ),
        //         child: TextComp(
        //           text: mainWeather['temp_min'].toInt().toString() + '\n min',
        //           fontSize: 18.0,
        //         ),
        //       ),
        //       TextComp(
        //         text: new DateFormat.jm()
        //             .format(DateTime.fromMillisecondsSinceEpoch(date * 1000)),
        //         fontSize: 22.0, fontWeight: FontWeight.bold,
        //       ),
        //       Container(
        //         padding: EdgeInsets.all(20),
        //         decoration: BoxDecoration(
        //           color: Color(AppColors.SECONDARY_COLOR).withOpacity(0.8),
        //           borderRadius: BorderRadius.all(Radius.circular(80)),
        //         ),
        //         child: TextComp(
        //           text: mainWeather['temp_max'].toInt().toString() + '\n max',
        //           fontSize: 18.0,
        //         ),
        //       ),
        //     ],
        //   ),
        // )
      ],
    );
  }
}
