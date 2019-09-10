import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:long_life_burning/modules/nearby/nearby.dart';
import 'package:long_life_burning/utils/helper/constants.dart' show SizeConfig;

class NearbyPage extends StatefulWidget {
  static const String routeName = '/';
  @override
  _NearbyPageState createState() => _NearbyPageState();
}

class _NearbyPageState extends State<NearbyPage> with TickerProviderStateMixin {

  final double _panelHeightClosed = SizeConfig.setHeight(200.0);
  final double _initRadius = 20.0;
  final MapController controller = MapController();
  double _lat = 19.027510;
  double _long = 99.900178;
  double _radius;

  @override
  Widget build(BuildContext context) {

    final double _panelHeightOpen = MediaQuery.of(context).size.height;
    final double _initFabHeight = _panelHeightClosed + _initRadius;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          MapView(
            controller: controller,
            center: LatLng(19.027510 - 0.015, 99.900178),
            listMark: <Marker>[
              Marker(
                point: LatLng(_lat, _long),
                builder: (_) => Icon(
                  Icons.location_on,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
          Positioned(
            right: 8.0,
            bottom: _initFabHeight,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.near_me,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                setState(() {
                  _lat = 19.027510;
                  _long = 99.900178;
                });
                controller.move(LatLng(_lat - 0.002, _long), 16.0);
              },
            ),
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              brightness: Brightness.light,
              elevation: 0.0,
            ),
          ),
          Positioned(
            top: SizeConfig.statusBarHeight,
            child: Container(
              padding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
              child: Text(
                "พะเยา",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.0),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    blurRadius: 16.0,
                  ),
                ],
              ),
            ),
          ),
          SlidePanel(
            title: 'Place for Runners',
            panelHeightOpen: _panelHeightOpen,
            panelHeightClosed: _panelHeightClosed,
            radius: _radius ?? _initRadius,
            fullscreen: _radius == 0,
            onPanelSlide: (value) {
              setState(() {
                _radius = _initRadius * (1 - value);
              });
            },
            onLocate: (double lat, double long) {
              setState(() {
                _lat = lat;
                _long = long;
              });
              controller.move(LatLng(_lat - 0.002, _long), 16.0);
            },
          ),
        ],
      ),
    );
    
  }

}
