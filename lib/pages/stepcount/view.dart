import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:long_life_burning/constants/platform.dart';
//import 'package:long_life_burning/modules/stepcount/stepcounter.dart';
import 'package:long_life_burning/modules/stepcount/forecast/forecast.dart';
import 'package:long_life_burning/modules/stepcount/forecast/radial_list.dart';

class StepCountView extends StatefulWidget {
  @override
  _StepCountViewState createState() => _StepCountViewState();
}

class _StepCountViewState extends State<StepCountView> with TickerProviderStateMixin {

  SlidingRadialListController slidingListController;

  @override
  void initState() {
    super.initState();
    slidingListController = SlidingRadialListController(
      itemCount: 3,
      vsync: this,
    )
    ..open();
  }

  @override
  void dispose() {
    slidingListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if ( Platforms.isIOS ) {
      return CupertinoPageScaffold(
        child: Stack(
          children: <Widget>[
            Forecast(
              radialList: RadialListViewModel(
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
              ),
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
            radialList: RadialListViewModel(
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
            ),
            slidingListController: slidingListController,
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              brightness: Brightness.dark,
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