part of nearby;

class MapView extends StatelessWidget {

  final List<Marker> listMark;
  final LatLng center;
  final double zoom;
  final double maxZoom;
  final bool active;
  final MapController controller;

  MapView({
    Key key,
    @required this.center,
    this.controller,
    this.zoom = 13.0,
    this.maxZoom = 18.0,
    this.active = true,
    this.listMark,
  }) :  assert(center != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: controller,
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