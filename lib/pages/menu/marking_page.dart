import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:long_life_burning/modules/nearby/map.dart';
import 'package:long_life_burning/utils/helper/constants.dart' show SizeConfig;

class MarkingPage extends StatefulWidget {
  static const String routeName = '/marking';
  @override
  _MarkingPageState createState() => _MarkingPageState();
}

class _MarkingPageState extends State<MarkingPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
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
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              brightness: Brightness.light,
              elevation: 0.0,
            ),
          ),
          Positioned(
            top: SizeConfig.statusBarHeight,
            child: Container(
              padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
              child: Text(
                "Marking",
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
            left: 18.0,
            top: SizeConfig.statusBarHeight,
            child: InkWell(
              onTap: () => Navigator.of(context).pop(),
              customBorder: CircleBorder(),
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_back),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      blurRadius: 16.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 18.0,
            top: SizeConfig.statusBarHeight,
            child: InkWell(
              onTap: () => print('share'),
              customBorder: CircleBorder(),
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.share),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      blurRadius: 16.0,
                    ),
                  ],
                ),
              ),
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