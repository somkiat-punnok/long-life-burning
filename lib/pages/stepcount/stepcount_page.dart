import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fit_kit/fit_kit.dart';
import 'package:long_life_burning/utils/helper/constants.dart';
import 'package:long_life_burning/modules/stepcount/stepcounter.dart'
  show
    kHeight,
    kWeight,
    kDateOfBirth,
    Diagnoses,
    RadialListViewModel,
    RadialListItemViewModel,
    SlidingRadialListController;
import 'package:long_life_burning/utils/providers/all.dart'
  show
    Provider,
    UserProvider;

import './record_page.dart';

class StepCountPage extends StatefulWidget {
  StepCountPage({ Key key }) : super(key: key);
  static const String routeName = '/';
  @override
  _StepCountPageState createState() => _StepCountPageState();
}

class _StepCountPageState extends State<StepCountPage> with TickerProviderStateMixin {

  SlidingRadialListController slidingListController;
  UserProvider userProvider;
  num _step, _distence, _calories;

  @override
  void initState() {
    super.initState();
    slidingListController = SlidingRadialListController(
      itemCount: 3,
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isCupertino) readDate();
    slidingListController?.reopen();
  }

  @override
  void dispose() {
    slidingListController?.dispose();
    super.dispose();
  }

  Future<void> readDate() async {
    if (!mounted) return;
    try {
      if (isCupertino && Configs.fitkit_permissions) {
        _step = 0;
        _distence = 0;
        _calories = 0;
        final DateTime _now = DateTime.now();
        for (DataType type in DataType.values) {
          if (type == DataType.STEP_COUNT) {
            await FitKit.read(
              type,
              DateTime.now().subtract(Duration(days: 1)),
              DateTime.now()
            )
            .then((data) {
              if (data != null && data.isNotEmpty) {
                data.forEach((d) {
                  if (d.dateFrom.day == _now.day && d.dateTo.day == _now.day) {
                    if (d.value > 0) {
                      _step += d.value ?? 0;
                      _calories += calculateCalories(
                        height: userProvider?.height ?? kHeight,
                        weight: userProvider?.weight ?? kWeight,
                        age: userProvider?.dateOfBirth ?? kDateOfBirth,
                        gender: userProvider?.gender ?? Gender.MALE,
                        seconds: ((d.dateTo.millisecondsSinceEpoch - d.dateFrom.millisecondsSinceEpoch) / 1000.0),
                        steps: d.value,
                      );
                    }
                  }
                });
              }
            });
          } else if (type == DataType.DISTANCE) {
            await FitKit.read(
              type,
              DateTime.now().subtract(Duration(days: 1)),
              DateTime.now()
            )
            .then((data) {
              if (data != null && data.isNotEmpty) {
                data.forEach((d) {
                  if (d.dateFrom.day == _now.day && d.dateTo.day == _now.day) {
                    if (d.value != 0) {
                      _distence += d.value ?? 0;
                    }
                  }
                });
              }
            });
          } else {
            continue;
          }
        }
        if (!mounted) return;
        setState(() {});
        return;
      } else if (isCupertino && !Configs.fitkit_permissions) {
        await FitKit
          .requestPermissions(DataType.values)
          .then(
            (result) => Configs.fitkit_permissions = result
          );
        await readDate();
        return;
      } else {
        return;
      }
    } catch (e) {
      print('Failed to read all values. $e');
      _step = 0;
      _distence = 0;
      _calories = 0;
      if (!mounted) return;
      setState(() {});
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Diagnoses(
            slidingListController: slidingListController,
            onDateText: () => Navigator.of(context).pushNamed(RecordPage.routeName),
            radialList: RadialListViewModel(
              items: [
                RadialListItemViewModel(
                  icon: AssetImage(RUNNERICON),
                  title: 'Steps',
                  subtitle: '${NumberFormat('#,###', 'en_US').format(_step)} step',
                ),
                RadialListItemViewModel(
                  icon: AssetImage(BURNICON),
                  title: 'Calories',
                  subtitle: '${NumberFormat('#,###.##', 'en_US').format(_calories)} kCal',
                ),
                RadialListItemViewModel(
                  icon: AssetImage(DISTANCEICON),
                  title: 'Distances',
                  subtitle: '${NumberFormat('#.##', 'en_US').format(_distence / 1000.0)} km',
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
              brightness: Brightness.dark,
              backgroundColor: Colors.transparent,
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
                    onPressed: () async => await Navigator.of(context).pushNamed(RecordPage.routeName),
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