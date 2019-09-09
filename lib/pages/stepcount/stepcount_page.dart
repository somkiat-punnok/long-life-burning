import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:fit_kit/fit_kit.dart';
import 'package:long_life_burning/utils/helper/constants.dart';
import 'package:long_life_burning/modules/stepcount/stepcounter.dart';
import 'package:long_life_burning/modules/stepcount/calculate.dart';
import 'package:long_life_burning/utils/widgets/date_utils.dart';

import './record_page.dart';

class StepCountPage extends StatefulWidget {
  static const String routeName = '/';
  @override
  _StepCountPageState createState() => _StepCountPageState();
}

class _StepCountPageState extends State<StepCountPage> with TickerProviderStateMixin {

  SlidingRadialListController slidingListController;
  bool initComplete = false;
  bool _permissions;
  num _step = 0;
  num _distence = 0;
  num _calories = 0;
  num _second = 0;

  @override
  void initState() {
    super.initState();
    readDate(DateTime.now());
    slidingListController = SlidingRadialListController(
      itemCount: 3,
      vsync: this,
    )
    ..open();
  }

  @override
  void didChangeDependencies() {
    if(initComplete) {
      readDate(DateTime.now());
      slidingListController.reopen();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    slidingListController.dispose();
    super.dispose();
  }

  Future<void> readDate(DateTime date) async {
    final bool before = (date.year <= DateTime.now().year) && (date.month <= DateTime.now().month) && (date.day <= DateTime.now().day);
    if (before) {
      try {
        _permissions = await FitKit.requestPermissions(DataType.values);
        if (!_permissions) {
          print("User declined permissions");
        } else {
          _step = 0;
          _distence = 0;
          _second = 0;
          final bool now = Utils.isSameDay(date, DateTime.now());
          for (DataType type in DataType.values) {
            if (before && type == DataType.STEP_COUNT) {
              await FitKit.read(type, now ? DateTime.now().subtract(Duration(days: 1)) : date, now ? DateTime.now() : date.add(Duration(days: 1)))
              .then((data) {
                if (data != null && data.isNotEmpty) {
                  data.forEach((value) {
                    if (value.dateFrom.day == date.day && value.dateTo.day == date.day) {
                      setState(() {
                        _step = _step + value.value.round() ?? 0;
                        if (value.value != 0) {
                          _second += ((value.dateTo.millisecondsSinceEpoch - value.dateFrom.millisecondsSinceEpoch) / 1000.0);
                        }
                      });
                    }
                  });
                }
              });
            }
            if (before && type == DataType.DISTANCE) {
              await FitKit.read(type, now ? DateTime.now().subtract(Duration(days: 1)) : date, now ? DateTime.now() : date.add(Duration(days: 1)))
              .then((data) {
                if (data != null && data.isNotEmpty) {
                  data.forEach((value) {
                    if (value.dateFrom.day == date.day && value.dateTo.day == date.day) {
                      setState(() {
                        _distence = _distence + value.value.round() ?? 0;
                      });
                    }
                  });
                }
              });
            }
          }
        }
      } catch (e) {
        print('Failed to read all values. $e');
      }
    }
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    initComplete = true;
    _calories = calculateEnergyExpenditure(1.7,DateTime(1998,1,1),70,Gender.MALE,_second,_step);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Forecast(
            slidingListController: slidingListController,
            onDateText: () => Navigator.of(context).pushNamed(RecordPage.routeName),
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
              automaticallyImplyLeading: false,
              centerTitle: false,
              backgroundColor: Colors.transparent,
              brightness: Brightness.dark,
              elevation: 0.0,
              title: Text(
                'Step Counts',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.setWidth(8.0)),
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pushNamed(RecordPage.routeName),
                    icon: Icon(
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