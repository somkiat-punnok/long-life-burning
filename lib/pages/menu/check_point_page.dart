import 'package:flutter/material.dart';
import 'package:long_life_burning/utils/helper/constants.dart' show SizeConfig;
import 'package:long_life_burning/modules/nearby/nearby.dart'
  show
    MapView,
    Marker,
    LatLng;

class CheckPointPage extends StatefulWidget {
  CheckPointPage({Key key}) : super(key: key);
  static const String routeName = '/marking';
  @override
  _CheckPointPageState createState() => _CheckPointPageState();
}

class _CheckPointPageState extends State<CheckPointPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          MapView(
            center: LatLng(13.437167, 101.484685),
            zoom: 5.8,
            maxZoom: 18,
            listMark: _buildMarker(),
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              automaticallyImplyLeading: false,
              brightness: Brightness.light,
              backgroundColor: Colors.transparent,
            ),
          ),
          Positioned(
            top: SizeConfig.statusBarHeight,
            child: Container(
              padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
              child: Text(
                "Check Point",
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
          Positioned(
            left: 8.0,
            top: SizeConfig.statusBarHeight,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.white,
              onPressed: () => Navigator.of(context).maybePop(),
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            right: 8.0,
            top: SizeConfig.statusBarHeight,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.share,
                color: Colors.black,
              ),
              onPressed: () => print('share'),
            ),
          ),
        ],
      ),
    );
  }

  List<Marker> _buildMarker() {
    return <Marker>[
      Marker(
        point: LatLng(18.793867, 98.997116),
        builder: (_) => Icon(
          Icons.location_on,
          color: Colors.redAccent,
          size: 24.0,
        ),
      ),
      Marker(
        point: LatLng(19.027510, 99.900178),
        builder: (_) => Icon(
          Icons.location_on,
          color: Colors.redAccent,
          size: 24.0,
        ),
      ),
      Marker(
        point: LatLng(18.027510, 100.200178),
        builder: (_) => Icon(
          Icons.location_on,
          color: Colors.redAccent,
          size: 24.0,
        ),
      ),
      Marker(
        point: LatLng(16.027510, 99.500178),
        builder: (_) => Icon(
          Icons.location_on,
          color: Colors.redAccent,
          size: 24.0,
        ),
      ),
      Marker(
        point: LatLng(16.427510, 101.800178),
        builder: (_) => Icon(
          Icons.location_on,
          color: Colors.redAccent,
          size: 24.0,
        ),
      ),
      Marker(
        point: LatLng(14.268217, 100.614021),
        builder: (_) => Icon(
          Icons.location_on,
          color: Colors.redAccent,
          size: 24.0,
        ),
      ),
      Marker(
        point: LatLng(13.361143, 100.984673),
        builder: (_) => Icon(
          Icons.location_on,
          color: Colors.redAccent,
          size: 24.0,
        ),
      ),
      Marker(
        point: LatLng(13.814029, 100.037292),
        builder: (_) => Icon(
          Icons.location_on,
          color: Colors.redAccent,
          size: 24.0,
        ),
      ),
    ];
  }

}
