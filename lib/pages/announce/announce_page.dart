import 'package:flutter/material.dart';
import 'package:long_life_burning/modules/announce/search.dart';
import 'package:long_life_burning/modules/announce/calendar.dart';
import 'package:long_life_burning/modules/announce/event/events.dart';
import 'package:long_life_burning/modules/calendar/table_calendar.dart';
import 'detail_page.dart';
import '../common/year_page.dart';

class AnnouncePage extends StatefulWidget {
  static const String routeName = '/';
  @override
  _AnnouncePageState createState() => _AnnouncePageState();
}

class _AnnouncePageState extends State<AnnouncePage> with TickerProviderStateMixin {

  final SearchEventDelegate _delegate = SearchEventDelegate();
  int lastMonth;
  DateTime _selectedDay;
  Map<DateTime, List> _events;
  List _onDayEvents;
  String _lastSelected;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    lastMonth = DateTime.now().month;
    _onDayEvents = EventList.events[_selectedDay] ?? [];
    _events = EventList.events;
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
      _onDayEvents = events;
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
            events: _events,
            selectedDay: _selectedDay,
            onDaySelected: _onDaySelected,
            onTitleText: () {
              _selection(context);
            },
            onIcon1: () async {
              final String selected = await showSearch<String>(
                context: context,
                delegate: _delegate,
              );
              if (selected != null && selected != _lastSelected) {
                setState(() {
                  _lastSelected = selected;
                });
              }
            },
            onIcon2: () => print("notify"),
            onIcon3: () => print("settings"),
            onVisibleDaysChanged: _onVisibleDaysChanged,
          ),
          EventToList(
            events: _onDayEvents,
            onClick: () => Navigator.of(context).pushNamed(EventDetailPage.routeName),
          ),
        ],
      ),
    );
  }

}
