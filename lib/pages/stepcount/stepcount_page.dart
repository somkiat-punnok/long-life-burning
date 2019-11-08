import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fit_kit/fit_kit.dart';
import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  StepCountPage({Key key}) : super(key: key);
  static const String routeName = '/';
  @override
  _StepCountPageState createState() => _StepCountPageState();
}

class _StepCountPageState extends State<StepCountPage> with TickerProviderStateMixin {

  SlidingRadialListController slidingListController;
  StreamSubscription<int> _subscription;
  UserProvider userProvider;
  num _currentStep, _previousStep;
  DateTime _currentTime, _previousTime;
  num _step, _distence, _calories;
  num _stepOld, _distenceOld, _caloriesOld;

  @override
  void initState() {
    super.initState();
    slidingListController = SlidingRadialListController(
      itemCount: 3,
      vsync: this,
    );
    if (isMaterial) startListening();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isCupertino) readDate();
    if (isMaterial) saveData();
    slidingListController?.reopen();
  }

  @override
  void dispose() {
    slidingListController?.dispose();
    _subscription?.cancel();
    super.dispose();
  }

  void startListening() async {
    final Pedometer _pedometer = new Pedometer();
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    final DateTime _now = DateTime.now();
    _stepOld = _pref.getInt("${_now.year}-${_now.month}-${_now.day}-step") ?? 0;
    _distenceOld = _pref.getDouble("${_now.year}-${_now.month}-${_now.day}-distences") ?? 0.0;
    _caloriesOld = _pref.getDouble("${_now.year}-${_now.month}-${_now.day}-calories") ?? 0.0;
    _step = _stepOld;
    _distence = _distenceOld;
    _calories = _caloriesOld;
    _currentStep = _step;
    _previousStep = _step;
    _currentTime = DateTime.now();
    _previousTime = DateTime.now();
    _subscription = _pedometer.pedometerStream.listen(_onData,
        onError: _onError, onDone: _onDone, cancelOnError: true);
  }

  void _onData(int steps) async {
    _step = _stepOld + steps;
    _currentStep = _step;
    _currentTime = DateTime.now();
    final num _stepNow = (_currentStep - _previousStep).abs();
    if (_stepNow > 0) {
      final Duration _elapsed = _currentTime.difference(_previousTime).abs();
      _calories += calculateCalories(
        height: userProvider?.height ?? kHeight,
        weight: userProvider?.weight ?? kWeight,
        age: userProvider?.dateOfBirth ?? kDateOfBirth,
        gender: userProvider?.gender ?? Gender.MALE,
        seconds: _elapsed.inSeconds,
        steps: _stepNow,
      );
      _distence = _distenceOld + calculateDistanceInKm(steps, calculateStepToMeters(175, Gender.MALE));
      setState(() {});
    }
    _previousTime = _currentTime;
    _previousStep = _currentStep;
  }

  void _onDone() => print("Finished pedometer tracking");
  void _onError(err) => print("Flutter Pedometer Error: $err");

  void saveData() async {
    final DateTime _now = DateTime.now();
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    await _pref.setInt("${_now.year}-${_now.month}-${_now.day}-step", _step);
    await _pref.setDouble("${_now.year}-${_now.month}-${_now.day}-distences", _distence);
    await _pref.setDouble("${_now.year}-${_now.month}-${_now.day}-calories", _calories);
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
                    if (d.value != 0) {
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