import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:fit_kit/fit_kit.dart';
import 'package:long_life_burning/utils/helper/constants.dart';
import 'package:long_life_burning/modules/stepcount/stepcounter.dart';
import 'package:long_life_burning/modules/stepcount/calculate.dart';

import './record_page.dart';

class StepCountPage extends StatefulWidget {
  static const String routeName = '/';
  @override
  _StepCountPageState createState() => _StepCountPageState();
}

class _StepCountPageState extends State<StepCountPage> with TickerProviderStateMixin {

  SlidingRadialListController slidingListController;
  num _step = 0;
  num _distence = 0;
  num _calories = 0;
  num _second = 0;
  bool initComplete = false;

  @override
  void initState() {
    super.initState();
    readAll();
    slidingListController = SlidingRadialListController(
      itemCount: 3,
      vsync: this,
    )
    ..open();
  }

  @override
  void didChangeDependencies() {
    if(initComplete) {
      readAll();
      slidingListController.reopen();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    slidingListController.dispose();
    super.dispose();
  }

  Future<void> readAll() async {
    try {
      final permissions = await FitKit.requestPermissions(DataType.values);
      if (!permissions) {
        print("User declined permissions");
      } else {
        final now = DateTime.now();
        _step = 0;
        _distence = 0;
        _second = 0;
        for (DataType type in DataType.values) {
          if (type == DataType.STEP_COUNT) {
            await FitKit.read(type, now.subtract(Duration(days: 1)), now)
            .then((data) => data.forEach((value) {
              if(value.dateFrom.day == now.day && value.dateTo.day == now.day) {
                setState(() {
                  _step = _step + value.value.round();
                  if (value.value != 0) {
                    _second = _second + (((value.dateTo.hour-value.dateFrom.hour)*60*60)+((value.dateTo.minute-value.dateFrom.minute)*60)+(value.dateTo.second-value.dateFrom.second));
                  }
                });
              }
            }));
          }
          if (type == DataType.DISTANCE) {
            await FitKit.read(type, now.subtract(Duration(days: 1)), now)
            .then((data) => data.forEach((value) {
              if(value.dateFrom.day == now.day && value.dateTo.day == now.day) {
                setState(() {
                  _distence = _distence + value.value.round();
                });
              }
            }));
          }
        }
      }
    } catch (e) {
      print('Failed to read all values. $e');
    }
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    initComplete = true;
    _calories = calculateEnergyExpenditure(1.7,DateTime(1998,1,1),70,Gender.MALE,_second,_step);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        children: <Widget>[
          Forecast(
            slidingListController: slidingListController,
            radialList: RadialListViewModel(
              items: [
                RadialListItemViewModel(
                  icon: AssetImage(Constants.runnerIcon),
                  title: 'Steps',
                  subtitle: '${NumberFormat('#,###', 'en_US').format(_step)} step',
                ),
                RadialListItemViewModel(
                  icon: AssetImage(Constants.burnIcon),
                  title: 'Calories',
                  subtitle: '${NumberFormat('#,###.##', 'en_US').format(_calories)} kCal',
                ),
                RadialListItemViewModel(
                  icon: AssetImage(Constants.distanceIcon),
                  title: 'Distances',
                  subtitle: '${NumberFormat('#.##', 'en_US').format(_distence/1000)} km',
                ),
              ],
            ),
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
                  child: InkWell(
                    onTap: () => Navigator.of(context).pushNamed(RecordPage.routeName),
                    customBorder: CircleBorder(),
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