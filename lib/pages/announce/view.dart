import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:long_life_burning/constants/constant.dart';
import 'package:long_life_burning/modules/announce/event/events.dart';
import 'package:long_life_burning/modules/announce/calendar.dart';
import 'package:long_life_burning/modules/calendar/table_calendar.dart';

class AnnounceView extends StatefulWidget {
  @override
  _AnnounceViewState createState() => _AnnounceViewState();
}

class _AnnounceViewState extends State<AnnounceView> with TickerProviderStateMixin {

  int lastMonth;
  DateTime _selectedDay;
  Map<DateTime, List> _events;
  List _selectedEvents;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    lastMonth = DateTime.now().month;
    _selectedEvents = Event.events[_selectedDay] ?? [];
    _events = Event.events;
  }

  void _onVisibleDaysChanged(first, last, format) {
    setState(() {
      if(format == CalendarFormat.month) {
        if (first.month == DateTime.now().month && lastMonth != DateTime.now().month) {
          _selectedDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
        } else if(first.month == DateTime.now().month && lastMonth == DateTime.now().month) {
          _selectedDay = _selectedDay;
        } else {
          _selectedDay = first;
        }
      }
      else {
        bool day = first.day <= _selectedDay.day && _selectedDay.day <= last.day;
        bool month = first.month <= _selectedDay.month && _selectedDay.month <= last.month;
        bool year = first.year <= _selectedDay.year && _selectedDay.year <= last.year;
        if(day && month && year) {
          _selectedDay = _selectedDay;
        } else {
          _selectedDay = first;
        }
      }
    });
  }

  void _onDaySelected(date, events) {
    setState(() {
      if(lastMonth != date.month) {
        lastMonth = date.month;
      }
      _selectedDay = date;
      _selectedEvents = events;
    });
  }

  _selection(BuildContext context) {
    Navigator.of(context).pushNamed(Constants.Years_Page).then((res) {
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
      body: Column(
        children: <Widget>[
          Calendar(
            events: _events,
            selectedDay: _selectedDay,
            onDaySelected: _onDaySelected,
            onTitleText: () {
              _selection(context);
            },
            onIcon1: () => print("search"),
            onIcon2: () => print("notify"),
            onIcon3: () => print("settings"),
            onVisibleDaysChanged: _onVisibleDaysChanged,
          ),
          EventList(
            events: _selectedEvents,
          ),
        ],
      ),
    );
  }

}