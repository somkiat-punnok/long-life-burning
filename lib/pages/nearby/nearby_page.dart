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
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  LocationData _location = LocationData.fromMap({
    'latitude': 19.027510,
    'longitude': 99.900178,
  });
  double _initFabHeight, _radius;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _initFabHeight = _panelHeightClosed + _initRadius;
  }

  void initPlatformState() async {
    try {
      await getCurrentLocation()
        .then((data) {
          if (data != null) {
            _location = data;
            _markers.clear();
            _addMarker(
              id: "user",
              latitude: data?.latitude,
              longitude: data?.longitude,
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
              toPlace: false,
            );
          }
        });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<LocationData> getCurrentLocation() async {
    Location location = Location();
    try {
      if (await location.serviceEnabled()) {
        if (await location.hasPermission()) {
          return await location.getLocation();
        } else {
          await location.requestPermission();
          if (await location.hasPermission()) {
            return await getCurrentLocation();
          }
          return null;
        }
      } else {
        await location.requestService();
        if (await location.serviceEnabled()) {
          return await getCurrentLocation();
        }
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
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
    setState(() {});
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
                await getCurrentLocation()
                  .then((data) {
                    if (data != null) {
                      _remove(id: "user");
                      _addMarker(
                        id: "user",
                        latitude: data?.latitude,
                        longitude: data?.longitude,
                        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
                      );
                    }
                  });
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
