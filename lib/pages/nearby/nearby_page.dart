import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
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
  final Location _locationService  = Location();
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  LocationData _location = LocationData.fromMap({
    'latitude': 19.027510,
    'longitude': 99.900178,
  });
  bool _serviceStatus = false;
  bool _permission = false;
  double _initFabHeight, _radius;

  @override
  void initState() {
    super.initState();
    _initFabHeight = _panelHeightClosed + _initRadius;
    initPlatformState();
  }

  void initPlatformState() async {
    await _locationService.changeSettings(accuracy: LocationAccuracy.HIGH, interval: 1000);
    try {
      _serviceStatus = await _locationService.serviceEnabled();
      if (_serviceStatus) {
        _permission = await _locationService.requestPermission();
        if (_permission) {
          _location = await _locationService.getLocation();
          _markers.clear();
          _addMarker(
            id: "user",
            latitude: _location?.latitude,
            longitude: _location?.longitude,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
            toPlace: false,
          );
        } else {
          _permission = await _locationService.requestPermission();
          initPlatformState();
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        if (serviceStatusResult) {
          initPlatformState();
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _addMarker({
    @required String id,
    @required double latitude,
    @required double longitude,
    BitmapDescriptor icon,
    bool toPlace = true,
  }) async {
    final GoogleMapController controller = await _controller.future;
    final MarkerId markerId = MarkerId(id);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(latitude, longitude),
      icon: icon,
    );
    _markers[markerId] = marker;
    setState(() {});
    if (toPlace) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng((latitude ?? 0.0015) - 0.0015, longitude),
            zoom: 16.0,
          )
        )
      );
    }
  }

  void _remove({@required String id}) {
    final MarkerId markerId = MarkerId(id);
    if (_markers.containsKey(markerId)) {
      _markers.remove(markerId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          MapView(
            controller: _controller,
            center: CameraPosition(
              target: LatLng((_location?.latitude ?? 0.01) - 0.01, _location?.longitude),
              zoom: 13.0,
            ),
            markers: Set<Marker>.of(_markers.values),
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
                if (_serviceStatus) {
                  if (_permission) {
                    _location = await _locationService.getLocation();
                    _remove(id: "user");
                    _addMarker(
                      id: "user",
                      latitude: _location?.latitude,
                      longitude: _location?.longitude,
                      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
                    );
                  } else {
                    _permission = await _locationService.requestPermission();
                  }
                } else {
                  bool serviceStatusResult = await _locationService.requestService();
                  if (serviceStatusResult) {
                    _serviceStatus = await _locationService.serviceEnabled();
                    if (!_permission) {
                      _permission = await _locationService.requestPermission();
                    }
                  }
                }
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
            panelHeightOpen: SizeConfig.screenHeight,
            panelHeightClosed: _panelHeightClosed,
            userLocation: LatLng(_location?.latitude, _location?.longitude),
            radius: _radius ?? _initRadius,
            fullscreen: _radius == 0,
            onPanelSlide: (value) {
              setState(() {
                _radius = _initRadius * (1 - value);
              });
            },
            onLocate: (double lat, double long) async {
              _remove(id: "place");
              _addMarker(
                id: "place",
                latitude: lat,
                longitude: long,
                icon: BitmapDescriptor.defaultMarker,
              );
            },
          ),
        ],
      ),
    );
  }

}
