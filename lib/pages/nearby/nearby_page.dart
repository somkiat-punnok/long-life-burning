import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:long_life_burning/modules/nearby/nearby.dart';
import 'package:long_life_burning/utils/helper/constants.dart' show SizeConfig;

class NearbyPage extends StatefulWidget {
  NearbyPage({Key key}) : super(key: key);
  static const String routeName = '/';
  @override
  _NearbyPageState createState() => _NearbyPageState();
}

class _NearbyPageState extends State<NearbyPage> with TickerProviderStateMixin {

  final double _panelHeightClosed = SizeConfig.setHeight(200.0);
  final double _initRadius = 20.0;
  final MapController controller = MapController();
  final Location _locationService  = Location();
  LocationData _location;
  double _radius;
  bool _permission = false;

  @override
  void initState() { 
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    await _locationService.changeSettings(accuracy: LocationAccuracy.HIGH, interval: 1000);
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        print("Permission: $_permission");
        if (_permission) {
          _location = await _locationService.getLocation();
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if (serviceStatusResult) {
          initPlatformState();
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }

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
            center: LatLng(_location.latitude - 0.015, _location.longitude),
            listMark: <Marker>[
              Marker(
                point: LatLng(_location.latitude, _location.longitude),
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
              onPressed: () async {
                _location = await _locationService.getLocation();
                controller.move(LatLng(_location.latitude - 0.002, _location.longitude), 16.0);
              },
            ),
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
                _location = LocationData.fromMap({
                  'latitude': lat,
                  'longitude': long,
                });
              });
              controller.move(LatLng(_location.latitude - 0.002, _location.longitude), 16.0);
            },
          ),
        ],
      ),
    );
  }

}
