import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

export 'package:flutter_map/flutter_map.dart' show Marker;
export 'package:latlong/latlong.dart' show LatLng;

class MapView extends StatelessWidget {

  final List<Marker> listMark;
  final LatLng center;
  final double zoom;
  final double maxZoom;
  final bool active;

  MapView({
    Key key,
    @required this.center,
    this.zoom = 13.0,
    this.maxZoom = 18.0,
    this.active = true,
    this.listMark,
  }) :  assert(center != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        interactive: active,
        center: center,
        zoom: zoom,
        maxZoom: maxZoom,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png"
        ),
        MarkerLayerOptions(
          markers: listMark,
        ),
      ],
    );
  }

}