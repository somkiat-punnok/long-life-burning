import 'package:flutter/material.dart';
import 'package:fit_kit/fit_kit.dart';
import 'package:long_life_burning/modules/stepcount/record/records.dart';
import 'package:long_life_burning/modules/stepcount/calculate.dart';
import 'package:long_life_burning/modules/stepcount/calendar.dart';
import 'package:long_life_burning/modules/calendar/calendar.dart'
  show
    CalendarController,
    CalendarFormat;
import 'package:long_life_burning/utils/helper/constants.dart'
  show
    Gender,
    isCupertino;
import 'package:long_life_burning/utils/widgets/date_utils.dart';

import '../common/year_page.dart';

class RecordPage extends StatefulWidget {
  static const String routeName = '/record';
  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {

  CalendarController _calendarController;
  DateTime _now;
  DateTime _selectedDay;
  bool _permissions;
  num _step = 0;
  num _distence = 0;
  num _second = 0;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _calendarController = CalendarController();
    _selectedDay = DateTime(_now.year, _now.month, _now.day);
    isCupertino ? init().then((_) => readDate(_selectedDay)) : null;
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    for(final data in _calendarController.visibleDays){
      if (Utils.isSameDay(data, _now)) {
        setState(() {
          _selectedDay = DateTime(_now.year, _now.month, _now.day);
        });
        break;
      }
      else if (_selectedDay.weekday == data.weekday) {
        setState(() {
          _selectedDay = DateTime(data.year, data.month, data.day);
        });
        break;
      }
    }
    _calendarController.setSelectedDay(_selectedDay, runCallback: true);
  }

  void _onDaySelected(DateTime date, List events) async {
    isCupertino
      ? await readDate(DateTime(date.year, date.month, date.day))
      : null;
    setState(() {
      _selectedDay = date;
    });
  }

  void _selection(BuildContext context) async => await Navigator.of(context).pushNamed(YearsCalendarPage.routeName).then(
    (res) {
      if (res != null) {
        final result = res as List;
        if(_now.year == result[0] && _now.month == result[1]) {
          setState(() {
            _selectedDay = DateTime(_now.year, _now.month, _now.day);
          });
        }
        else {
          setState(() {
            _selectedDay = DateTime(result[0], result[1], 1);
          });
        }
        _calendarController.setSelectedDay(_selectedDay, runCallback: true);
      }
    }
  );

  Future<void> init() async => await FitKit.requestPermissions(DataType.values).then((result) => _permissions = result);

  Future<void> readDate(DateTime date) async {
    if ((date.year <= _now.year) && (date.month <= _now.month) && (date.day <= _now.day)) {
      try {
        if (!_permissions) {
          print("User declined permissions");
          await FitKit.requestPermissions(DataType.values).then((result) => _permissions = result);
        } else {
          _step = 0;
          _distence = 0;
          _second = 0;
          final bool now = Utils.isSameDay(date, _now);
          for (DataType type in DataType.values) {
            if (type == DataType.STEP_COUNT) {
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
            else if (type == DataType.DISTANCE) {
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
    else {
      _step = 0;
      _distence = 0;
      _second = 0;
    }
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Calendar(
            controller: _calendarController,
            onDaySelected: _onDaySelected,
            onTitleText: () {
              _selection(context);
            },
            onVisibleDaysChanged: _onVisibleDaysChanged,
          ),
          RecordToList(
            step: _step,
            cal: calculateEnergyExpenditure(1.7, DateTime(1998,1,1), 70, Gender.MALE, _second, _step),
            dist: _distence/1000,
          ),
        ],
      ),
    );
  }

}