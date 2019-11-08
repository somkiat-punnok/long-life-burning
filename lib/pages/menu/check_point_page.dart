import 'package:flutter/material.dart';
import 'package:long_life_burning/utils/helper/constants.dart' show SizeConfig;
import 'package:long_life_burning/modules/nearby/nearby.dart'
  show
    MapView,
    Marker,
    LatLng,
    MarkerId,
    BitmapDescriptor;

class CheckPointPage extends StatefulWidget {
  CheckPointPage({ Key key }) : super(key: key);
  static const String routeName = '/marking';
  @override
  _CheckPointPageState createState() => _CheckPointPageState();
}

class _CheckPointPageState extends State<CheckPointPage> {

  final List<double> lat = <double>[
    18.793867,
    19.027510,
    18.027510,
    16.027510,
    16.427510,
    14.268217,
    13.361143,
    13.814029,
  ];

  final List<double> long = <double>[
    98.997116,
    99.900178,
    100.200178,
    99.500178,
    101.800178,
    100.614021,
    100.984673,
    100.037292,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          MapView(
            markers: Set<Marker>.of(_buildMarker()),
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

  Iterable<Marker> _buildMarker() {
    return Iterable<Marker>.generate(lat.length, (i) => Marker(
        markerId: MarkerId("mark" + (i+1).toString()),
        position: LatLng(lat[i], long[i]),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
  }

}
