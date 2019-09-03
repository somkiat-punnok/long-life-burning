import 'package:flutter/material.dart';
import 'package:long_life_burning/modules/announce/search.dart';
import 'package:long_life_burning/modules/announce/calendar.dart';
import 'package:long_life_burning/modules/calendar/calendar.dart'
  show
    CalendarController,
    CalendarFormat;
import 'package:long_life_burning/modules/announce/event/events.dart';

import 'detail_page.dart';
import 'notify_page.dart';
import 'setting_event_page.dart';
import '../common/year_page.dart';

class AnnouncePage extends StatefulWidget {
  static const String routeName = '/';
  @override
  _AnnouncePageState createState() => _AnnouncePageState();
}

class _AnnouncePageState extends State<AnnouncePage> with TickerProviderStateMixin {

  final SearchEventDelegate _delegate = SearchEventDelegate();
  CalendarController _calendarController;
  ScrollController _eventController;
  DateTime _selectedDay;
  Map<DateTime, List> _events;
  List _onDayEvents;
  String _lastSelected;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _eventController = ScrollController()..addListener(_scrollListener);
    _selectedDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    _onDayEvents = EventList.events[_selectedDay] ?? [];
    _events = EventList.events;
  }

  @override
  void dispose() {
    _calendarController.dispose();
    _eventController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_eventController.offset > _eventController.position.minScrollExtent && _calendarController.calendarFormat != CalendarFormat.week) {
      _calendarController.setCalendarFormat(CalendarFormat.week);
    }
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    _calendarController.setSelectedDay(_selectedDay, runCallback: true);
  }

  void _onDaySelected(DateTime date, List events) {
    setState(() {
      _selectedDay = date;
      _onDayEvents = events;
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
            events: _events,
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
            onIcon2: () async => await Navigator.of(context).pushNamed(NotifyPage.routeName),
            onIcon3: () async => await Navigator.of(context).pushNamed(SetEventPage.routeName),
            onVisibleDaysChanged: _onVisibleDaysChanged,
          ),
          EventToList(
            controller: _eventController,
            events: _onDayEvents,
            onClick: () async => await Navigator.of(context).pushNamed(EventDetailPage.routeName),
            onDown: (b) {
              if (b && _calendarController.calendarFormat != CalendarFormat.month) {
                _calendarController.setCalendarFormat(CalendarFormat.month);
              }
            },
          ),
        ],
      ),
    );
  }

}
