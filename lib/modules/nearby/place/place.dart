library place;

import 'dart:convert' show json;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:long_life_burning/utils/widgets/carousel_card.dart';
import 'package:long_life_burning/utils/helper/constants.dart'
  show
    IMAGES,
    SizeConfig;
import '../header/header.dart' show StickyHeaderBuilder;
import '../utils.dart';

part './place_model.dart';
part './place_detail.dart';

class Place extends StatefulWidget {

  final String title;
  final bool fullscreen;
  final LatLng userLocation;
  final LocateCallback onTapLocate;

  Place({
    Key key,
    @required this.title,
    this.fullscreen,
    this.userLocation,
    this.onTapLocate,
  }) :  assert(title != null && title != ''),
        super(key: key);

  @override
  _PlaceState createState() => _PlaceState();
}

class _PlaceState extends State<Place> {

  List<Widget> items;

  void init(List<DocumentSnapshot> list) async {
    try {
      items = await mapItem(list);
    } catch (e) {
      print('Error: $e');
    }
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("Map").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();
        init(snapshot.data.documents);
        return Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: SizeConfig.statusBarHeight + 20.0,
                  bottom: 20.0,
                ),
                child: Text(
                  widget.title.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
              ),
              CarouselCard(
                viewportFraction: 1.0,
                aspectRatio: SizeConfig.aspectRatio * 1.25,
                autoPlay: false,
                enlargeCenterPage: false,
                items: (items != null && items.isNotEmpty)
                    ? items
                    : [
                      Container(
                        child: Center(
                          child: Text('Hasn\'t place.'),
                        ),
                      ),
                    ],
              ),
            ],
          ),
        );
      }
    );
  }

  Future<List<Widget>> mapItem(List<DocumentSnapshot> list) async {
    final List<Widget> _result = <Widget>[];
    final List<String> _image = <String>[
      "$IMAGES/216155.jpg",
      "$IMAGES/216178.jpg",
      "$IMAGES/216197.jpg",
    ];
    num i = 0;
    list.forEach((l) async {
      if (i == 3) i = 0;
      final Map<String, dynamic> data = l.data;
      data["id"] = l.documentID;
      data["image"] = _image[i];
      final PlaceModel p = PlaceModel.fromMap(data);
      final Geolocator geo = new Geolocator();
      final double dist = await geo
        .distanceBetween(
          widget.userLocation?.latitude,
          widget.userLocation?.longitude,
          p.lat,
          p.long,
        );
      _result.add(
        PlaceDetail(
          item: p,
          distance: dist,
          fullscreen: widget.fullscreen,
          onTap: widget.onTapLocate != null
              ? () => widget.onTapLocate(p.lat, p.long)
              : () {},
        )
      );
      i++;
    });
    return _result;
  }

}
