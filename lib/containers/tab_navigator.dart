import 'package:flutter/material.dart';

import '../product_manager.dart';
import './nearby_weather.dart';

class TabNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: [
            ProductManager(),
            NearByWeather(),
            Icon(Icons.directions_bike),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.cloud_circle, size: 40)),
            Tab(icon: Icon(Icons.format_align_justify, size: 40)),
            Tab(icon: Icon(Icons.account_circle, size: 40)),
          ],
          labelColor: Colors.purple,
          unselectedLabelColor: Colors.grey,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: Colors.purple,
        ),
      ),
    );
  }
}
