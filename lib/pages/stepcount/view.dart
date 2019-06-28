//import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:pedometer/pedometer.dart';
import 'package:long_life_burning/constants/platform.dart';
//import 'package:long_life_burning/modules/stepcount/stepcounter.dart';
import 'package:long_life_burning/modules/stepcount/forecast/forecast.dart';
import 'package:long_life_burning/modules/stepcount/forecast/radial_list.dart';

class StepCountView extends StatefulWidget {
  @override
  _StepCountViewState createState() => _StepCountViewState();
}

class _StepCountViewState extends State<StepCountView> with TickerProviderStateMixin {

  //StepCounter step = StepCounter();
  //StreamSubscription<int> _subscription;
  SlidingRadialListController slidingListController;
  RadialListViewModel forecastRadialList;
  //String _step = "Unknown";

  @override
  void initState() {
    super.initState();
    // Pedometer pedometer = Pedometer();
    // _subscription = pedometer.stepCountStream.listen(
    //   _onData,
    //   onError: _onError,
    //   onDone: _onDone,
    //   cancelOnError: true
    // );
    slidingListController = new SlidingRadialListController(
      itemCount: 3,
      vsync: this,
    )
    ..open();
  }

  // void _onData(int step) async {
  //   setState(() {
  //     _step = "$step";
  //   });
  // }

  // void reset() {
  //   setState(() {
  //     int step = 0;
  //     _step = "$step";
  //   });
  // }

  // void _onDone() {
  //   print("Flutter Pedometer start.");
  // }

  // void _onError(error) {
  //   print("Flutter Pedometer Error: $error");
  // }

  @override
  Widget build(BuildContext context) {

    forecastRadialList = RadialListViewModel(
      items: [
        RadialListItemViewModel(
          icon: AssetImage('assets/icons/runner.png'),
          title: 'Steps',
          subtitle: '0 step',
        ),
        RadialListItemViewModel(
          icon: AssetImage('assets/icons/burn.png'),
          title: 'Calories',
          subtitle: '0 kCal',
        ),
        RadialListItemViewModel(
          icon: AssetImage('assets/icons/distance.png'),
          title: 'Distances',
          subtitle: '0 km',
        ),
      ],
    );

    //slidingListController.close().then((_) => slidingListController.open());

    if ( Platforms.isIOS ) {
      return CupertinoPageScaffold(
        child: Stack(
          children: <Widget>[
            Forecast(
              radialList: forecastRadialList,
              slidingListController: slidingListController,
            ),
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: CupertinoNavigationBar(
                backgroundColor: Colors.transparent,
                middle: Text(
                  'Step Counts',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Forecast(
            radialList: forecastRadialList,
            slidingListController: slidingListController,
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: Text(
                'Step Counts',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }
  
}