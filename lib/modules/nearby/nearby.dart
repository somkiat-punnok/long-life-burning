library nearby;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:long_life_burning/utils/widgets/carousel_card.dart';
import 'package:long_life_burning/utils/helper/constants.dart' show SizeConfig;

export 'package:flutter_map/flutter_map.dart' show Marker;
export 'package:latlong/latlong.dart' show LatLng;

part './map.dart';
part './place/place.dart';
part './place/placedetail.dart';
part './panel/panel.dart';
part './panel/panel_controller.dart';

typedef void LocateCallback(double lat, double long);
typedef void PanelSlideCallback(double pos);

class SlidePanel extends StatelessWidget {

  final double panelHeightOpen;
  final double panelHeightClosed;
  final double radius;
  final PanelSlideCallback onPanelSlide;
  final LocateCallback onLocate;
  final bool fullscreen;
  final String title;

  SlidePanel({
    Key key,
    @required this.title,
    this.panelHeightOpen,
    this.panelHeightClosed,
    this.fullscreen,
    this.radius,
    this.onPanelSlide,
    this.onLocate,
  }) :  assert(title != null && title != ''),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      maxHeight: panelHeightOpen,
      minHeight: panelHeightClosed,
      onPanelSlide: onPanelSlide,
      collapsed: Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(top: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(12.0))
              ),
            ),
          ],
        ),
      ),
      panel: Place(
        title: title,
        fullscreen: fullscreen,
        onTapLocate: onLocate,
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
      ),
    );
  }
}