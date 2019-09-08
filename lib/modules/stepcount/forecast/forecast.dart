import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:long_life_burning/utils/helper/constants.dart' show SizeConfig;
import 'package:long_life_burning/modules/stepcount/forecast/background/background_with_rings.dart';
import 'package:long_life_burning/modules/stepcount/forecast/radial_list.dart';

class Forecast extends StatelessWidget {

  final RadialListViewModel radialList;
  final SlidingRadialListController slidingListController;
  final DateTime date;
  final VoidCallback onDateText;

  Forecast({
    Key key,
    @required this.radialList,
    @required this.slidingListController,
    this.date,
    this.onDateText,
  }) : super(key: key);

  Widget _dayText() {
    DateTime time = date ?? DateTime.now();
    return Padding(
      padding: EdgeInsets.only(top: 0.0, left: SizeConfig.setWidth(15.0)),
      child: GestureDetector(
        onTap: onDateText,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '${time.day}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 80.0,
                ),
              ),
              Text(
                month(time.month),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50.0,
                ),
              ),
              Text(
                '${time.year}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50.0,
                ),
              ),
            ],
          ),
        ),
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
        SlidingRadialList(
          radialList: radialList,
          controller: slidingListController,
        ),
        _dayText(),
      ],
    );
  }
}
