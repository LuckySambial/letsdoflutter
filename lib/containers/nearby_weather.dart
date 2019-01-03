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
  List<Weather> finalData;
  @override
  void initState() {
    getNearWeather().then((response) {
      setState(() {
        finalData = response;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 500,
        padding: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/morning.jpg"),
            fit: BoxFit.cover,
          ),
        ),
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
        height: MediaQuery.of(context).size.height,
        width: 500,
        child: ListView.builder(
          itemCount: cityList.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: GestureDetector(
                    onTap: () =>
                        print("clicked!   " + cityList[index].name.toString()),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFB4C56C).withOpacity(0.5),
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                TextComp(text: cityList[index].name.toString()),
                                Image.network(
                                    'https://openweathermap.org/img/w/' +
                                        cityList[index].icon +
                                        '.png')
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 11, 11, 11),
                              alignment: Alignment(-1.0, -1.0),
                              child: TextComp(
                                  text: cityList[index].title.toString()),
                            )
                          ],
                        ))));
          },
        ),
      );
    } else {
      return Image(image: new AssetImage("assets/loader.gif"));
    }
  }

  Future<List<Weather>> getNearWeather() async {
    List<Weather> dataList = <Weather>[];
    String url =
        'https://api.openweathermap.org/data/2.5/find?lat=30.666&lon=76.78&cnt=20&appid=47ee9f58572d02786966d718ee8292cb';
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
        String temp = mainWeather['temp'].toString();
        dataList.add(new Weather(
          name: item['name'].toString(),
          temp: temp,
          title: weatherDetails['main'],
          icon: weatherDetails['icon'],
          description: weatherDetails['description'],
        ));
      }
      return dataList;
    } else {
      return dataList;
    }
  }
}

class Weather {
  final String name;
  final String temp;
  final String title;
  final String icon;
  final String description;
  Weather({this.name, this.temp, this.title, this.icon, this.description});
}
