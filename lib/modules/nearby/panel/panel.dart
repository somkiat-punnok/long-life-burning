library panel;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../place/place.dart' show Place;
import '../utils.dart';

part './panel_widget.dart';
part './panel_controller.dart';

typedef void PanelSlideCallback(double pos);

enum SlideDirection{
  UP,
  DOWN,
}

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