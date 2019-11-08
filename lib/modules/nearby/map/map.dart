library map;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final CameraPosition _kCenter = CameraPosition(
  target: LatLng(19.027510, 99.900178),
  zoom: 5.75,
);

class MapView extends StatelessWidget {

  final Set<Marker> markers;
  final Set<Polygon> polygons;
  final Set<Polyline> polylines;
  final CameraPosition center;
  final Completer<GoogleMapController> controller;

  MapView({
    Key key,
    this.controller,
    this.center,
    this.markers,
    this.polygons,
    this.polylines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: center ?? _kCenter,
      mapType: MapType.normal,
      markers: markers,
      polygons: polygons,
      polylines: polylines,
      onMapCreated: (control) {
        controller?.complete(control);
      },
    );
  }

}