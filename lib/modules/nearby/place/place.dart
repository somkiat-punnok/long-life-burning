import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:long_life_burning/utils/helper/constants.dart' show SizeConfig;

import './placedetail.dart';

class Place extends StatefulWidget {
  
  final String title;
  final bool fullscreen;

  Place({
    Key key,
    @required this.title,
    this.fullscreen,
  }) :  assert(title != null && title != ''),
        super(key: key);

  @override
  _PlaceState createState() => _PlaceState();
}

class _PlaceState extends State<Place> {

  PageController _controller;

  @override
  void initState() { 
    super.initState();
    _controller = PageController(initialPage: 1, viewportFraction: 1.0);
  }

  @override
  void dispose() { 
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: widget.fullscreen ? SizeConfig.statusBarHeight + 10.0 : 40.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.title.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 30.0,),
        PageView(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            PlaceDetail(),
            PlaceDetail(),
            PlaceDetail(),
          ],
        ),
      ],
    );
  }
}
