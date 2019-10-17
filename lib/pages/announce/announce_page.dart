import 'package:flutter/cupertino.dart';
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
  AnnouncePage({Key key}) : super(key: key);
  static const String routeName = '/';
  @override
  _AnnouncePageState createState() => _AnnouncePageState();
}

class _AnnouncePageState extends State<AnnouncePage> with TickerProviderStateMixin {

  SearchEventDelegate _delegate;
  IconData _arrow_icon;
  DateTime _now;
  CalendarController _calendarController;
  DateTime _selectedDay;
  Map<DateTime, List> _events;
  List _onDayEvents;

  @override
  void initState() {
    super.initState();
    _arrow_icon = Icons.arrow_drop_up;
    _now = DateTime.now();
    _delegate = SearchEventDelegate();
    _calendarController = CalendarController();
    _selectedDay = DateTime(_now.year, _now.month, _now.day);
    _onDayEvents = Event.events[_selectedDay] ?? [];
    _events = Event.events;
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    // _calendarController.setSelectedDay(_selectedDay, runCallback: true);
  }

  void _onDaySelected(DateTime date, List events) {
    _calendarController?.setCalendarFormat(CalendarFormat.month);
    setState(() {
      _selectedDay = date;
      _onDayEvents = events;
    });
  }

  void _selection(BuildContext context) async => await Navigator.of(context).pushNamed(YearsCalendarPage.routeName).then(
    (res) {
      if (res != null) {
        final result = res as List;
        if (_now.year == result[0] && _now.month == result[1]) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only( bottom: 8.0 ),
            child: Calendar(
              controller: _calendarController,
              events: _events,
              onDaySelected: _onDaySelected,
              onTitleText: () {
                _selection(context);
              },
              onIcon1: () async {
                await showSearch<String>(
                  context: context,
                  delegate: _delegate,
                );
              },
              onIcon2: () async => await Navigator.of(context).pushNamed(NotifyPage.routeName),
              onIcon3: () async => await Navigator.of(context).pushNamed(SettingEventPage.routeName),
              onVisibleDaysChanged: _onVisibleDaysChanged,
            ),
          ),
          Expanded(
            flex: 0,
            child: CupertinoButton(
              color: Colors.blue,
              padding: EdgeInsets.zero,
              borderRadius: BorderRadius.zero,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Opacity(
                    opacity: 0.0,
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Icon(
                        Icons.arrow_drop_down,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                      "${_selectedDay.year} - ${_selectedDay.month > 9 ? _selectedDay.month : "0" + _selectedDay.month.toString()} - ${_selectedDay.day > 9 ? _selectedDay.day : "0" + _selectedDay.day.toString()}",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Icon(
                      _arrow_icon,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                if ((_calendarController?.calendarFormat ?? CalendarFormat.month) == CalendarFormat.month) {
                  _arrow_icon = Icons.arrow_drop_down;
                  _calendarController?.setCalendarFormat(CalendarFormat.week);
                } else {
                  _arrow_icon = Icons.arrow_drop_up;
                  _calendarController?.setCalendarFormat(CalendarFormat.month);
                }
                setState(() {});
              },
            ),
          ),
          EventView(
            events: _onDayEvents,
            onClick: () async => await Navigator.of(context).pushNamed(EventDetailPage.routeName),
          ),
        ],
      ),
    );
  }

}
