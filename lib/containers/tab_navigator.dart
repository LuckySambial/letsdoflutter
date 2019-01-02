import 'package:flutter/material.dart';

import '../product_manager.dart';

class TabNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: TabBarView(
            children: [
              ProductManager(),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.cloud_circle, size: 40)),
              Tab(icon: Icon(Icons.location_city, size: 40)),
              Tab(icon: Icon(Icons.face, size: 40)),
            ],
            labelColor: Colors.purple,
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.purple,
          ),
        ),
      ),
    );
  }
}
