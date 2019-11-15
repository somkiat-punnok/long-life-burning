library map;

import 'dart:async' show Completer;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'
  show
    GoogleMap,
    MapType,
    LatLng,
    Marker,
    Polygon,
    Polyline,
    CameraPosition,
    GoogleMapController;

final CameraPosition _kCenter = CameraPosition(
  target: LatLng(13.03887, 101.490104),
  zoom: 5.75,
);

class MapView extends StatelessWidget {

  final Set<Marker> markers;
  final Set<Polygon> polygons;
  final Set<Polyline> polylines;
  final CameraPosition center;
  final Completer<GoogleMapController> controller;
  final bool compassEnabled;
  final bool mapToolbarEnabled;
  final bool rotateGesturesEnabled;
  final bool scrollGesturesEnabled;
  final bool zoomGesturesEnabled;
  final bool tiltGesturesEnabled;
  final bool myLocationEnabled;
  final bool myLocationButtonEnabled;
  final bool indoorViewEnabled;
  final bool trafficEnabled;

  MapView({
    Key key,
    this.controller,
    this.center,
    this.markers,
    this.polygons,
    this.polylines,
    this.compassEnabled = true,
    this.mapToolbarEnabled = true,
    this.rotateGesturesEnabled = true,
    this.scrollGesturesEnabled = true,
    this.zoomGesturesEnabled = true,
    this.tiltGesturesEnabled = true,
    this.myLocationEnabled = false,
    this.myLocationButtonEnabled = false,
    this.indoorViewEnabled = false,
    this.trafficEnabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: center ?? _kCenter,
      mapType: MapType.normal,
      markers: markers ?? Set<Marker>(),
      polygons: polygons ?? Set<Polygon>(),
      polylines: polylines ?? Set<Polyline>(),
      compassEnabled: compassEnabled ?? true,
      mapToolbarEnabled: mapToolbarEnabled ?? true,
      rotateGesturesEnabled: rotateGesturesEnabled ?? true,
      scrollGesturesEnabled: scrollGesturesEnabled ?? true,
      zoomGesturesEnabled: zoomGesturesEnabled ?? true,
      tiltGesturesEnabled: tiltGesturesEnabled ?? true,
      myLocationEnabled: myLocationEnabled ?? false,
      myLocationButtonEnabled: myLocationButtonEnabled ?? false,
      indoorViewEnabled: indoorViewEnabled ?? false,
      trafficEnabled: trafficEnabled ?? false,
      onMapCreated: (control) {
        controller?.complete(control);
      },
    );
  }

}