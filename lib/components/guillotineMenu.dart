import 'dart:math';

import 'package:flutter/material.dart';
import '../containers/nearby_weather.dart';
import '../containers/tab_navigator.dart';
import '../containers/forecast.dart';
import '../containers/mapWeather.dart';
import '../containers/settings.dart';
import '../utils/Colors.dart';

class GuillotineMenu extends StatefulWidget {
  String currentCityId, currentCityName;

  GuillotineMenu({this.currentCityId, this.currentCityName});
  @override
  _GuillotineMenuState createState() => _GuillotineMenuState();
}

class _GuillotineMenuState extends State<GuillotineMenu>
    with SingleTickerProviderStateMixin {
  final GlobalKey _menuIconkey = GlobalKey();

  final Color _menuBg = Color(AppColors.PRIMARY_COLOR).withOpacity(0.9);

  Animation<double> _menuAnimation;

  Animation<double> _toolbarTitleFadeAnimation;

  AnimationController _guillotineMenuAnimationController;

  @override
  void initState() {
    super.initState();

/*
This is to check the offset of the menu Icon in top left corner.
    // WidgetsBinding.instance.addPostFrameCallback(_getPosition);
*/

    _guillotineMenuAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 550),
    )..addListener(() {
        setState(() {});
      });

    // Menu Animation

    _menuAnimation = Tween(begin: -pi / 2, end: 0.0).animate(CurvedAnimation(
        parent: _guillotineMenuAnimationController,
        curve: Curves.bounceOut,
        reverseCurve: Curves.bounceIn));

    // Toolbar Title Transition

    _toolbarTitleFadeAnimation =
        Tween(begin: 1.0, end: 0.0).animate(_guillotineMenuAnimationController);
  }

  _getPosition(_) {
    _getOffset();
  }

  void _getOffset() {
    final RenderBox offsetBox = _menuIconkey.currentContext.findRenderObject();
    final Offset offset = offsetBox.localToGlobal(Offset.zero);
    print("Offset : $offset");
  }

  @override
  void dispose() {
    super.dispose();
    _guillotineMenuAnimationController.dispose();
  }

  void _onMenuIconClick() {
    if (_isMenuVisible()) {
      _guillotineMenuAnimationController.reverse();
    } else {
      _guillotineMenuAnimationController.forward();
    }
  }

  bool _isMenuVisible() {
    final AnimationStatus status = _guillotineMenuAnimationController.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _menuAnimation.value,
      origin: Offset(32.0, 50.0),
      alignment: Alignment.topLeft,
      child: Material(
        color: _isMenuVisible() ? _menuBg : Colors.transparent,
        child: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: _toolbar(),
                ),
                Expanded(
                  flex: 8,
                  child: _menuItems(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _toolbar() {
    return RotatedBox(
      quarterTurns: 1,
      child: Container(
        // padding: const EdgeInsets.only(left: 16),
        child: Row(
          children: <Widget>[_toolbarIcon(), _toolbarTitle()],
        ),
      ),
    );
  }

  Widget _toolbarIcon() {
    return IconButton(
      key: _menuIconkey,
      icon: Icon(
        Icons.menu,
        color: Colors.white,
      ),
      onPressed: () => _onMenuIconClick(),
    );
  }

  Widget _toolbarTitle() {
    return FadeTransition(
      opacity: _toolbarTitleFadeAnimation,
      child: Container(
        margin: const EdgeInsets.only(left: 16),
        child: Text(
          "",
          style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              letterSpacing: 2.0,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _menuItems() {
    return Container(
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
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          ListTile(
            onTap: () => onItemPress(WeatherForecast(
                cityId: widget.currentCityId, name: widget.currentCityName)),
            leading: Icon(
              Icons.account_circle,
              color: Colors.white,
            ),
            title: Text(
              "Weather Forecast",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () => onItemPress(NearByWeather()),
            leading: Icon(
              Icons.rss_feed,
              color: Colors.white,
            ),
            title: Text(
              "NearBy Citeies",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () => onItemPress(MapWeather()),
            leading: Icon(
              Icons.map,
              color: Colors.white,
            ),
            title: Text(
              "MAP",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () => onItemPress(Settings()),
            leading: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            title: Text(
              "SETTINGS",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  onItemPress(screenName) {
    _guillotineMenuAnimationController.reverse();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => screenName));
  }
}
