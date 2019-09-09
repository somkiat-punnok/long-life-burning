import 'package:flutter/material.dart';
import 'package:fit_kit/fit_kit.dart';
import 'package:long_life_burning/utils/helper/constants.dart' show Gender;
import 'package:long_life_burning/modules/stepcount/record/records.dart';
import 'package:long_life_burning/modules/stepcount/calculate.dart';
import 'package:long_life_burning/modules/stepcount/calendar.dart';
import 'package:long_life_burning/modules/calendar/calendar.dart'
  show
    CalendarController,
    CalendarFormat;
import 'package:long_life_burning/utils/widgets/date_utils.dart';

import '../common/year_page.dart';

class RecordPage extends StatefulWidget {
  static const String routeName = '/record';
  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {

  CalendarController _calendarController;
  DateTime _selectedDay;
  bool _permissions;
  num _step = 0;
  num _distence = 0;
  num _second = 0;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _selectedDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    readDate(_selectedDay);
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    _calendarController.visibleDays.forEach((d) {
      if (Utils.isSameDay(d, DateTime.now())) {
        setState(() {
          _selectedDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
        });
      }
      else if (_selectedDay.weekday == d.weekday) {
        setState(() {
          _selectedDay = DateTime(d.year, d.month, d.day);
        });
      }
    });
    _calendarController.setSelectedDay(_selectedDay, runCallback: true);
  }

  void _onDaySelected(DateTime date, List events) async {
    ((date.year <= DateTime.now().year) && (date.month <= DateTime.now().month) && (date.day <= DateTime.now().day))
    ? await readDate(DateTime(date.year, date.month, date.day))
    : null;
    setState(() {
      _selectedDay = date;
      if ((DateTime.now().year <= date.year) && (DateTime.now().month <= date.month) && (DateTime.now().day < date.day)) {
        _step = 0;
        _distence = 0;
        _second = 0;
      }
    });
  }

  _selection(BuildContext context) async => await Navigator.of(context).pushNamed(YearsCalendarPage.routeName).then(
    (res) {
      if (res != null) {
        final result = res as List;
        setState(() {
          if(DateTime.now().year == result[0] && DateTime.now().month == result[1]) {
            _selectedDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
          }
          else {
            _selectedDay = DateTime(result[0], result[1], 1);
          }
        });
        _calendarController.setSelectedDay(_selectedDay, runCallback: true);
      }
    }
  );

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