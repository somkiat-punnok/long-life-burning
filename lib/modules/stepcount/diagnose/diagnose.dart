library diagnose;

import 'dart:ui';
import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' show CupertinoColors;
import 'package:meta/meta.dart';
import 'package:long_life_burning/utils/helper/constants.dart'
  show
    RUNIMAGE,
    isMaterial,
    SizeConfig;

part './background/circle.dart';
part './background/background_with_rings.dart';
part './radial/radial_list.dart';
part './radial/radial_item.dart';
part './radial/radial_model.dart';
part './radial/radial_position.dart';
part './sliding_controller.dart';

enum RadialListState {
  closed,
  slidingOpen,
  open,
  fadingOut,
}

class Diagnoses extends StatelessWidget {

  final RadialListViewModel radialList;
  final SlidingRadialListController slidingListController;
  final VoidCallback onDateText;

  Diagnoses({
    Key key,
    @required this.radialList,
    @required this.slidingListController,
    this.onDateText,
  }) : super(key: key);

  Widget _dayText() {
    DateTime time = DateTime.now();
    return Padding(
      padding: EdgeInsets.only(top: 0.0, left: SizeConfig.setWidth(10.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: onDateText,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Text(
                '${time.day}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 80.0,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: onDateText,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Text(
                month(time.month),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50.0,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: onDateText,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Text(
                '${time.year}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String month(int month) {
    switch (month) {
      case 1:
        return "JAN";
        break;
      case 2:
        return "FAB";
        break;
      case 3:
        return "MAR";
        break;
      case 4:
        return "APR";
        break;
      case 5:
        return "MAY";
        break;
      case 6:
        return "JUN";
        break;
      case 7:
        return "JUL";
        break;
      case 8:
        return "AUG";
        break;
      case 9:
        return "SEP";
        break;
      case 10:
        return "OCT";
        break;
      case 11:
        return "NOV";
        break;
      case 12:
        return "DEC";
        break;
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        BackgroundWithRings(),
        _dayText(),
        SlidingRadialList(
          radialList: radialList,
          controller: slidingListController,
          onTap: onDateText,
        ),
      ],
    );
  }
}
