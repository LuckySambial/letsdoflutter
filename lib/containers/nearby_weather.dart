import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import '../components/text_comp.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import '../utils/Config.dart';

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
    // getCurrentWeather();
    getNearWeather('30.234234', '76.5345').then((response) {
      setState(() {
        finalData = response;
      });
    });
    super.initState();
  }

  void getCurrentWeather() async {
    Geolocator geolocatorr = await Geolocator()
      ..forceAndroidLocationManager = true;
    GeolocationStatus geolocationStatus =
        await geolocatorr.checkGeolocationPermissionStatus();

    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    getNearWeather(position.latitude.toString(), position.longitude.toString())
        .then((response) {
      setState(() {
        finalData = response;
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
        getNearWeather(lat, lng).then((response) {
          setState(() {
            finalData = response;
          });
        });
      } else {
        lat = '30.0000';
        lng = '76.89889';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Near By Weather'),
        backgroundColor: Color(0xFFB4C56C).withOpacity(0.7),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: 0),
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/hounted.jpg"),
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
        height: MediaQuery.of(context).size.height - 81,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: cityList.length,
          itemBuilder: (context, index) {
            return renderListItem(cityList[index]);
          },
        ),
      );
    } else {
      return Image(image: new AssetImage("assets/loader.gif"));
    }
  }

  Future<List<Weather>> getNearWeather(String lat, String lng) async {
    List<Weather> dataList = <Weather>[];
    String url = Config.NEARBY_CITIES+'lat=' +
        lat +
        '&lon=' +
        lng +
        '&cnt=20&appid=47ee9f58572d02786966d718ee8292cb&units=metric';
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
        double temp = mainWeather['temp'];
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

  Widget renderListItem(city) {
    return ListTile(
      title: GestureDetector(
        onTap: () => print("clicked!   " + city.name.toString()),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFB4C56C).withOpacity(0.3),
            // borderRadius: BorderRadius.all(Radius.circular(50.0)),
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      TextComp(
                          text: (city.temp).toInt().toString() + '°',
                          fontSize: 40.0),
                      TextComp(
                          text: city.name.toString(),
                          fontSize: 12.0,
                          width: 100.0),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Image.network('https://openweathermap.org/img/w/' +
                          city.icon +
                          '.png'),
                      TextComp(text: city.title.toString(), fontSize: 15.0),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 11, 11, 11),
                    alignment: Alignment(-1.0, -1.0),
                    child: TextComp(text: city.title.toString()),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Weather {
  final String name;
  final double temp;
  final String title;
  final String icon;
  final String description;
  Weather({this.name, this.temp, this.title, this.icon, this.description});
}
