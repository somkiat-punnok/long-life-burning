import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:long_life_burning/widgets/platform_widgets.dart';
import 'package:long_life_burning/modules/stepcount/stepcounter.dart';

class StepCountPage extends StatefulWidget {
  @override
  _StepCountPageState createState() => _StepCountPageState();
}

class _StepCountPageState extends State<StepCountPage> with TickerProviderStateMixin {

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

    var button = Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(Constants.recordRoute),
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Icon(
            Icons.event_note,
            color: Colors.white,
            size: 30.0,
          ),
        ),
      ),
    );

    return PlatformScaffold(
      android: (_) => MaterialScaffoldData(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: true,
      ),
      ios: (_) => CupertinoPageScaffoldData(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomInsetTab: true,
      ),
      body: Stack(
        children: <Widget>[
          Forecast(
            radialList: RadialListViewModel(
              items: [
                RadialListItemViewModel(
                  icon: AssetImage(Constants.runnerIcon),
                  title: 'Steps',
                  subtitle: '0 step',
                ),
                RadialListItemViewModel(
                  icon: AssetImage(Constants.burnIcon),
                  title: 'Calories',
                  subtitle: '0 kCal',
                ),
                RadialListItemViewModel(
                  icon: AssetImage(Constants.distanceIcon),
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
            child: PlatformAppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              title: Text(
                'Step Counts',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                ),
              ),
              android: (_) => MaterialAppBarData(
                brightness: Brightness.dark,
                elevation: 0.0,
                actions: <Widget>[
                  button,
                ],
              ),
              ios: (_) => CupertinoNavigationBarData(
                actionsForegroundColor: Colors.transparent,
                border: Border.all(
                  color: Colors.transparent,
                  width: 0.0,
                  style: BorderStyle.none
                ),
                trailing: button,
              ),
            ),
          ),
        ],
      ),
    );

  }
  
}