import 'package:flutter/material.dart';
import 'package:long_life_burning/modules/stepcount/record/records.dart';
import 'package:long_life_burning/modules/stepcount/calendar.dart';
import '../common/year_page.dart';

class RecordPage extends StatefulWidget {
  static const String routeName = '/record';
  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> with TickerProviderStateMixin {

  int lastMonth;
  DateTime _selectedDay;
  Map<DateTime, List> _records;
  List _selectedRecords;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    lastMonth = DateTime.now().month;
    _selectedRecords = RecordList.records[_selectedDay] ?? [];
    _records = RecordList.records;
  }

  void _onVisibleDaysChanged(first, last, format) {
    setState(() {
      bool day = first.day <= _selectedDay.day && _selectedDay.day <= last.day;
      bool month = first.month <= _selectedDay.month && _selectedDay.month <= last.month;
      bool year = first.year <= _selectedDay.year && _selectedDay.year <= last.year;
      if(day && month && year) {
        _selectedDay = _selectedDay;
      } else {
        _selectedDay = first;
      }
    });
  }

  void _onDaySelected(date, events) {
    setState(() {
      if(lastMonth != date.month) {
        lastMonth = date.month;
      }
      _selectedDay = date;
      _selectedRecords = events;
    });
  }

  _selection(BuildContext context) {
    Navigator.of(context).pushNamed(YearsCalendarPage.routeName).then((res) {
      final result = res as List;
      setState(() {
        if(DateTime.now().year == result[0] && DateTime.now().month == result[1]) {
          _selectedDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
        }
        else {
          _selectedDay = DateTime(result[0], result[1], 1);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: Column(
        children: <Widget>[
          Calendar(
            records: _records,
            selectedDay: _selectedDay,
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