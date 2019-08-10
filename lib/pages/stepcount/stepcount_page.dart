import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:long_life_burning/utils/constants.dart';
import 'package:long_life_burning/modules/stepcount/stepcounter.dart';
import 'record_page.dart';

class StepCountPage extends StatefulWidget {
  static const String routeName = '/';
  @override
  _StepCountPageState createState() => _StepCountPageState();
}

class _StepCountPageState extends State<StepCountPage> with TickerProviderStateMixin {

  SlidingRadialListController slidingListController;
  bool initComplete = false;

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
  void didChangeDependencies() {
    if(initComplete) {
      slidingListController.reopen();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    slidingListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initComplete = true;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
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
            child: AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              title: Text(
                'Step Counts',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.setWidth(36.0),
                  fontWeight: FontWeight.bold,
                ),
              ),
              brightness: Brightness.dark,
              elevation: 0.0,
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.setWidth(8.0)),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(RecordPage.routeName),
                    child: Icon(
                      Icons.event_note,
                      color: Colors.white,
                      size: SizeConfig.setWidth(30.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
}