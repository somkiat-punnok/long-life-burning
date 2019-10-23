library nearby;

import 'dart:async' show Completer;
import 'dart:convert' show json;
import 'dart:math' show min, max;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:long_life_burning/utils/widgets/carousel_card.dart';
import 'package:long_life_burning/utils/helper/constants.dart' show SizeConfig;

export 'package:google_maps_flutter/google_maps_flutter.dart';

part './map.dart';
part './header/render.dart';
part './header/widget.dart';
part './place/place.dart';
part './place/place_model.dart';
part './place/place_detail.dart';
part './panel/panel.dart';
part './panel/panel_controller.dart';

typedef void LocateCallback(double lat, double long);
typedef void PanelSlideCallback(double pos);

final CameraPosition _kCenter = CameraPosition(
  target: LatLng(13.437167, 101.484685),
  zoom: 5.75,
);

class SlidePanel extends StatelessWidget {

  final double panelHeightOpen;
  final double panelHeightClosed;
  final double radius;
  final LatLng userLocation;
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
    this.userLocation,
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
        userLocation: userLocation,
        onTapLocate: onLocate,
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
      ),
    );
  }

}
