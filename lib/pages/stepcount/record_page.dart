import 'package:flutter/material.dart';
import 'package:long_life_burning/modules/stepcount/record/records.dart';
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

class _RecordPageState extends State<RecordPage> with TickerProviderStateMixin {

  CalendarController _calendarController;
  DateTime _selectedDay;
  Map<DateTime, List> _records;
  List _selectedRecords;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _selectedDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    _selectedRecords = RecordList.records[_selectedDay] ?? [];
    _records = RecordList.records;
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    bool now = false;
    bool last = false;
    _calendarController.visibleDays.forEach((d) {
      if (!now && Utils.isSameDay(d, DateTime.now())) {
        now = true;
      }
      if (!last && Utils.isSameDay(d, _selectedDay)) {
        last = true;
      }
    });
    setState(() {
      if (now) {
        _selectedDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
      } else if (last) {
        _selectedDay = _selectedDay;
      } else {
        _selectedDay = first;
      }
    });
    _calendarController.setSelectedDay(_selectedDay, runCallback: true);
  }

  void _onDaySelected(DateTime date, List events) {
    setState(() {
      _selectedDay = date;
      _selectedRecords = events;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: Column(
        children: <Widget>[
          Calendar(
            controller: _calendarController,
            records: _records,
            onDaySelected: _onDaySelected,
            onTitleText: () {
              _selection(context);
            },
            onVisibleDaysChanged: _onVisibleDaysChanged,
          ),
          RecordToList(
            records: _selectedRecords,
          ),
        ],
      ),
    );
  }

}