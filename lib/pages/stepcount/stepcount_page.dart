import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fit_kit/fit_kit.dart';
import 'package:long_life_burning/utils/helper/constants.dart';
import 'package:long_life_burning/modules/stepcount/calculate.dart' show calculateCalories;
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
  StepCountPage({Key key}) : super(key: key);
  static const String routeName = '/';
  @override
  _StepCountPageState createState() => _StepCountPageState();
}

class _StepCountPageState extends State<StepCountPage> with TickerProviderStateMixin {

  SlidingRadialListController slidingListController;
  bool initComplete = false;
  num _step = 0;
  num _distence = 0;
  num _calories = 0;
  num _second = 0;

  @override
  void initState() {
    super.initState();
    // if (isCupertino) {
    readDate();
    // }
    slidingListController = SlidingRadialListController(
      itemCount: 3,
      vsync: this,
    )
    ..open();
  }

  @override
  void didChangeDependencies() {
    if(initComplete) {
      // if (isCupertino) {
      readDate();
      // }
      slidingListController.reopen();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    slidingListController.dispose();
    super.dispose();
  }

  Future<void> readDate() async {
    try {
      if (!Configs.fitkit_permissions) {
        await FitKit.requestPermissions(DataType.values).then((result) => Configs.fitkit_permissions = result);
        await readDate();
      } else {
        _step = 0;
        _distence = 0;
        _second = 0;
        for (DataType type in DataType.values) {
          if (type == DataType.STEP_COUNT) {
            await FitKit.read(type, DateTime.now().subtract(Duration(days: 1)), DateTime.now())
              .then((data) {
                if (data != null && data.isNotEmpty) {
                  data.forEach((value) {
                    if (value.dateFrom.day == DateTime.now().day && value.dateTo.day == DateTime.now().day) {
                      if (value.value != 0) {
                        setState(() {
                          _step += value.value.round() ?? 0;
                          _second += ((value.dateTo.millisecondsSinceEpoch - value.dateFrom.millisecondsSinceEpoch) / 1000.0);
                        });
                      }
                    }
                  });
                }
              });
          }
          if (type == DataType.DISTANCE) {
            await FitKit.read(type, DateTime.now().subtract(Duration(days: 1)), DateTime.now())
              .then((data) {
                if (data != null && data.isNotEmpty) {
                  data.forEach((value) {
                    if (value.dateFrom.day == DateTime.now().day && value.dateTo.day == DateTime.now().day) {
                      if (value.value != 0) {
                        setState(() {
                          _distence += value.value.round() ?? 0;
                        });
                      }
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
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    initComplete = true;
    _calories = calculateCalories(
      userProvider.height ?? kHeight,
      userProvider.dateOfBirth ?? kDateOfBirth,
      userProvider.weight ?? kWeight,
      userProvider.gender ?? Gender.MALE,
      _second,
      _step,
    );
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