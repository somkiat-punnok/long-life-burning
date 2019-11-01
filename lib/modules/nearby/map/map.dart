part of nearby;

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