import 'package:flutter/material.dart';

import '../components/text_comp.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingsState();
  }
}

class SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: TextComp(
      //     text: 'Settings',
      //   ),
      // ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 150.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Sliver App Bar"),
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 150.0,
            delegate: SliverChildBuilderDelegate((context, index) => ListTile(
                  title: Text("List item $index"),
                )),
          )
        ],
      ),
    );
  }
}
