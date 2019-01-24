import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../components/text_comp.dart';
import '../utils/Colors.dart';

class MapWeather extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MapWeatherState();
  }
}

class MapWeatherState extends State<MapWeather> {
  GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
  }

  void _onAddMarkerButtonPressed() {
    mapController.addMarker(
      MarkerOptions(
        position: LatLng(
          mapController.cameraPosition.target.latitude,
          mapController.cameraPosition.target.longitude,
        ),
        infoWindowText: InfoWindowText('Random Place', '5 Star Rating'),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: TextComp(
      //     text: 'Map Weather',
      //   ),
      // ),
      body: Container(
        child: Column(
          children: <Widget>[
            // RaisedButton(
            //     child: TextComp(
            //       text: 'Go to London',
            //       color: Color(AppColors.PRIMARY_COLOR).withOpacity(0.9),
            //     ),
            //     onPressed: () {
            //       // _onAddMarkerButtonPressed();
            //       mapController
            //           .animateCamera(CameraUpdate.newCameraPosition(
            //         const CameraPosition(
            //           bearing: 270.0,
            //           target: LatLng(30.42199, 76.0862),
            //           tilt: 30.0,
            //           zoom: 14.0,
            //         ),
            //       ));
            //       mapController.addMarker(
            //         MarkerOptions(
            //           position: LatLng(30.42199, 76.0862),
            //           infoWindowText: InfoWindowText("Title", "Content"),
            //           icon: BitmapDescriptor.fromAsset("assets/c2.jpg"),
            //         ),
            //       );
            //     }),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.4,
              child: GoogleMap(
                options: GoogleMapOptions(
                  trackCameraPosition: true,
                  mapType: MapType.satellite,
                  cameraPosition: CameraPosition(
                    target: LatLng(30.4219999, 76.0862462),
                    zoom: 14.0,
                  ),
                  rotateGesturesEnabled: false,
                  scrollGesturesEnabled: false,
                  tiltGesturesEnabled: false,
                ),
                onMapCreated: _onMapCreated,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }
}
