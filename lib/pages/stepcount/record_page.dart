import 'package:flutter/material.dart';
import 'package:fit_kit/fit_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:long_life_burning/modules/stepcount/calendar.dart';
import 'package:long_life_burning/modules/stepcount/stepcounter.dart'
  show
    kHeight,
    kWeight,
    kDateOfBirth,
    RecordToList;
import 'package:long_life_burning/modules/calendar/calendar.dart'
  show
    CalendarController,
    CalendarFormat;
import 'package:long_life_burning/utils/helper/constants.dart'
  show
    Gender,
    Configs,
    isMaterial,
    isCupertino,
    calculateCalories;
import 'package:long_life_burning/utils/providers/all.dart'
  show
    Provider,
    UserProvider;
import 'package:long_life_burning/utils/widgets/date_utils.dart';

import '../common/year_page.dart';

class RecordPage extends StatefulWidget {
  RecordPage({ Key key }) : super(key: key);
  static const String routeName = '/record';
  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {

  CalendarController _calendarController;
  UserProvider userProvider;
  DateTime _now;
  DateTime _selectedDay;
  num _step = 0;
  num _distence = 0;
  num _calories = 0;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _calendarController = CalendarController();
    _selectedDay = DateTime(_now.year, _now.month, _now.day);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    readDate(_selectedDay);
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    for (final data in _calendarController.visibleDays){
      if (Utils.isSameDay(data, _now)) {
        _selectedDay = DateTime(_now.year, _now.month, _now.day);
        break;
      }
      else if (_selectedDay.weekday == data.weekday) {
        _selectedDay = DateTime(data.year, data.month, data.day);
        break;
      }
    }
    _calendarController.setSelectedDay(_selectedDay, runCallback: true);
  }

  void _onDaySelected(DateTime date, List events) async {
    await readDate(DateTime(date.year, date.month, date.day));
    setState(() {
      _selectedDay = date;
    });
  }

  void _selection(BuildContext context) async => await Navigator.of(context)
    .pushNamed(YearsCalendarPage.routeName)
    .then((res) {
      if (res != null) {
        final result = res as List;
        if(_now.year == result[0] && _now.month == result[1]) {
          _selectedDay = DateTime(_now.year, _now.month, _now.day);
        }
        else {
          _selectedDay = DateTime(result[0], result[1], 1);
        }
        _calendarController.setSelectedDay(_selectedDay, runCallback: true);
      }
    });

  Future<void> readDate(DateTime date) async {
    if (!mounted) return;
    final DateTime now = DateTime.now();
    if ((date.year <= now.year) && (date.month <= now.month) && (date.day <= now.day)) {
      try {
        if (isCupertino && Configs.fitkit_permissions) {
          _step = 0;
          _distence = 0.0;
          _calories = 0.0;
          final bool dateNow = Utils.isSameDay(date, now);
          for (DataType type in DataType.values) {
            if (type == DataType.STEP_COUNT) {
              await FitKit.read(
                type,
                dateNow
                  ? DateTime.now().subtract(Duration(days: 1))
                  : date,
                dateNow
                  ? DateTime.now()
                  : date.add(Duration(days: 1))
              )
              .then((data) {
                if (data != null && data.isNotEmpty) {
                  data.forEach((d) {
                    if (d.dateFrom.day == date.day && d.dateTo.day == date.day) {
                      if (d.value != 0) {
                        _step += d.value ?? 0;
                        _calories += calculateCalories(
                          height: userProvider?.height ?? kHeight,
                          age: userProvider?.dateOfBirth ?? kDateOfBirth,
                          weight: userProvider?.weight ?? kWeight,
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
                dateNow
                  ? DateTime.now().subtract(Duration(days: 1))
                  : date,
                dateNow
                  ? DateTime.now()
                  : date.add(Duration(days: 1))
              )
              .then((data) {
                if (data != null && data.isNotEmpty) {
                  data.forEach((d) {
                    if (d.dateFrom.day == date.day && d.dateTo.day == date.day) {
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
          await readDate(date);
          return;
        } else if (isMaterial) {
          final SharedPreferences _pref = await SharedPreferences.getInstance();
          _step = _pref.getInt("${date.year}-${date.month}-${date.day}-step") ?? 0;
          _distence = _pref.getDouble("${date.year}-${date.month}-${date.day}-distences") ?? 0.0;
          _calories = _pref.getDouble("${date.year}-${date.month}-${date.day}-calories") ?? 0.0;
          if (!mounted) return;
          setState(() {});
          return;
        } else {
          return;
        }
      } catch (e) {
        print('Failed to read all values. $e');
        _step = 0;
        _distence = 0.0;
        _calories = 0.0;
        if (!mounted) return;
        setState(() {});
        return;
      }
    }
    else {
      _step = 0;
      _distence = 0.0;
      _calories = 0.0;
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
            step: _step ?? 0,
            cal: _calories ?? 0.0,
            dist: ((_distence ?? 0.0) / 1000.0),
          ),
        ],
      ),
    );
  }

}
