import 'package:flutter/material.dart';

import '../components/text_comp.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

class NearByWeather extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NearByWeatherState();
  }
}

class NearByWeatherState extends State<NearByWeather> {
  List<String> finalData;
  @override
  void initState() {
    getNearWeather().then((response) {
      print(response.toString());
      setState(() {
        finalData=response;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Near By Weather'),
      ),
      body: Container(
        width: 500,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.purple[400],
          Colors.purple[600],
          Colors.purple[800],
          Colors.purple[900],
        ])),
        child: Column(
          children: <Widget>[
            checkForWeathersList(finalData),
          ],
        ),
      ),
    );
  }

  Widget checkForWeathersList(cityList) {
    if (cityList != null) {
      return Container(
        height: 500,
        width: 500,
        child: ListView.builder(
          itemCount: cityList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: TextComp(text:cityList[index]),
            );
          },
        ),
      );
    } else {
      return TextComp(text: 'Loading!!!');
    }
  }

  Future<List<String>> getNearWeather() async {
    List<String> dataList = <String>[];
    String url =
        'https://api.openweathermap.org/data/2.5/find?lat=30.666&lon=76.78&cnt=10&appid=47ee9f58572d02786966d718ee8292cb';
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.OK) {
      var jsonString = await response.transform(utf8.decoder).join();
      var data = json.decode(jsonString);
      for (Map<String, dynamic> item in data['list']) {
        dataList.add(item['name'].toString());
      }
      return dataList;
    } else {
      return dataList;
    }
  }
}

