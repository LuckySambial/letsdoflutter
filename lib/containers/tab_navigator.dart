import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

import '../product_manager.dart';
import './settings.dart';
import './nearby_weather.dart';
import './splash.dart';
import '../components/text_comp.dart';

class TabNavigator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TabNavigatorState();
  }
}

class TabNavigatorState extends State<TabNavigator> {
  int currentPage = 0;
  GlobalKey bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: _getPage(currentPage),
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          TabData(iconData: Icons.home, title: "HOME"),
          TabData(iconData: Icons.list, title: "NEAR BY"),
          TabData(iconData: Icons.settings, title: "SETTINGS")
        ],
        onTabChangedListener: (position) {
          print(position);
          setState(() {
            currentPage = position;
          });
        },
      ),
    );
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        return ProductManager();
      case 1:
        return NearByWeather();
      case 2:
        return Splash();
      default:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("This is the basket page"),
            RaisedButton(
              child: Text(
                "Start new page",
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () {},
            )
          ],
        );
    }
  }
}
