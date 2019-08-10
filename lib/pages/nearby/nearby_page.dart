import 'package:flutter/material.dart';
import 'package:long_life_burning/modules/nearby/nearby.dart';
import 'package:long_life_burning/modules/nearby/map.dart';

class NearbyPage extends StatefulWidget {
  static const String routeName = '/';
  @override
  _NearbyPageState createState() => _NearbyPageState();
}

class _NearbyPageState extends State<NearbyPage> with TickerProviderStateMixin {

  final double _panelHeightClosed = 200.0;
  final double _initRadius = 20.0;
  double _radius;

  @override
  Widget build(BuildContext context) {

    final double _panelHeightOpen = MediaQuery.of(context).size.height;
    final double _initFabHeight = _panelHeightClosed + _initRadius;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          MapView(
            center: LatLng(19.027510, 99.900178),
            listMark: <Marker>[
              Marker(
                point: LatLng(19.027510, 99.900178),
                builder: (_) => Icon(
                  Icons.location_on,
                  color: Colors.redAccent,
                  size: 48.0,
                ),
              ),
            ],
          ),
          Positioned(
            right: 20.0,
            bottom: _initFabHeight,
            child: FloatingActionButton(
              child: Icon(
                Icons.gps_fixed,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {},
              backgroundColor: Colors.white,
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
            top: 40.0,
            child: Container(
              padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
              child: Text(
                "Nearby Locations",
                style: TextStyle(
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
            onPanelSlide: (value) {
              setState(() {
                _radius = _initRadius * (1 - value);
              });
            },
          ),
        ],
      ),
    );
    
  }

}
