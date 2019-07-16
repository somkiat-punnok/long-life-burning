import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(19.027510, 99.900178),
        zoom: 13,
        maxZoom: 18,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png"
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              point: LatLng(19.027510, 99.900178),
              builder: (_) => Icon(
                Icons.location_on,
                color: Colors.redAccent,
                size: 48.0,
              ),
              height: 60.0,
            ),
          ]
        ),
      ],
    );
  }
}