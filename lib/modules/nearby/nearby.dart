import 'package:flutter/material.dart';
import 'package:long_life_burning/modules/nearby/place/place.dart';
import 'package:long_life_burning/modules/nearby/panel/panel.dart';

class SlidePanel extends StatelessWidget {

  final double panelHeightOpen;
  final double panelHeightClosed;
  final double radius;
  final void Function(double) onPanelSlide;
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
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
      ),
    );
  }
}