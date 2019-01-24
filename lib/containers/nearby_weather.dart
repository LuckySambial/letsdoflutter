import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import '../components/text_comp.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import '../utils/Config.dart';
import './forecast.dart';
import './mapWeather.dart';
import '../utils/Colors.dart';

class NearByWeather extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NearByWeatherState();
  }
}

class NearByWeatherState extends State<NearByWeather>
    with SingleTickerProviderStateMixin {
  List<Weather> finalData;
  TabController tabController;
  @override
  void initState() {
    // getCurrentWeather();
    getNearWeather('30.234234', '76.5345').then((response) {
      setState(() {
        finalData = response;
      });
    });
    super.initState();
    tabController = new TabController(vsync: this, length: 2);
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
    var tabBarItem = new TabBar(
      tabs: [
        new Tab(
          icon: new Icon(Icons.list),
        ),
        new Tab(
          icon: new Icon(Icons.grid_on),
        ),
      ],
      controller: tabController,
      indicatorColor: Colors.white,
    );
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: new AppBar(
          title: new Text("NearBy Weather"),
          bottom: tabBarItem,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(top: 0),
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
          child: TabBarView(
            controller: tabController,
            children: [
              checkForWeathersList(finalData),
              MapWeather(),
            ],
          ),
        ),
      ),
    );
  }

  Widget checkForWeathersList(List<Weather> cityList) {
    if (cityList != null) {
      return Container(
        height: MediaQuery.of(context).size.height / 1.1,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          // gridDelegate:
          //     new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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
    String url = Config.NEARBY_CITIES +
        'lat=' +
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
          cityId: item['id'].toString(),
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

  Widget renderListItem(Weather city) {
    return ListTile(
      title: GestureDetector(
        onTap: () => (onCityTap(city)),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              stops: [0.1, 0.5, 0.7, 0.9],
              colors: [
                Color(AppColors.PRIMARY_COLOR).withOpacity(0.9),
                Color(AppColors.PRIMARY_COLOR).withOpacity(0.7),
                Color(AppColors.PRIMARY_COLOR).withOpacity(0.5),
                Color(AppColors.PRIMARY_COLOR).withOpacity(0.4),
              ],
            ),
          ),
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: TextComp(text: city.name.toString(), fontSize: 18.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      TextComp(
                          text: (city.temp).toInt().toString() + '°c',
                          fontSize: 30.0),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Image.network('https://openweathermap.org/img/w/' +
                          city.icon +
                          '.png'),
                      // TextComp(text: city.title.toString(), fontSize: 15.0),
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

  onCityTap(Weather city) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              WeatherForecast(cityId: city.cityId, name: city.name)),
    );
  }
}

class Weather {
  final String cityId;
  final String name;
  final double temp;
  final String title;
  final String icon;
  final String description;
  Weather(
      {this.cityId,
      this.name,
      this.temp,
      this.title,
      this.icon,
      this.description});
}
