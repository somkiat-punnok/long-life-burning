import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:long_life_burning/modules/announce/search/search.dart';
import 'package:long_life_burning/modules/announce/calendar.dart';
import 'package:long_life_burning/utils/helper/constants.dart'
  show
    Configs,
    MAP_PROVINCE,
    MAP_CATEGORIES;
import 'package:long_life_burning/modules/calendar/calendar.dart'
  show
    CalendarController,
    CalendarFormat;
import 'package:long_life_burning/modules/announce/event/events.dart'
  show
    Event,
    EventView;
import 'package:long_life_burning/utils/providers/all.dart'
  show
    Provider,
    EventProvider,
    SettingProvider;

import './detail_page.dart';
import './setting_event_page.dart';
import '../common/year_page.dart';

class AnnouncePage extends StatefulWidget {
  AnnouncePage({ Key key }) : super(key: key);
  static const String routeName = '/';
  @override
  _AnnouncePageState createState() => _AnnouncePageState();
}

class _AnnouncePageState extends State<AnnouncePage> {

  CalendarController _calendarController;
  Map<DateTime, List> _events;
  List _onDayEvents;
  IconData _arrow_icon;
  DateTime _selectedDay;
  DateTime _now;

  @override
  void initState() {
    super.initState();
    _arrow_icon = Icons.arrow_drop_up;
    _now = DateTime.now();
    _calendarController = CalendarController();
    _selectedDay = DateTime(_now.year, _now.month, _now.day);
    _events = <DateTime, List>{};
    _onDayEvents = [];
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    // _calendarController.setSelectedDay(_selectedDay, runCallback: true);
  }

  void _onDaySelected(DateTime date, List event) {
    _selectedDay = date;
    _calendarController?.setCalendarFormat(CalendarFormat.month);
    setState(() {});
  }

  void _selection(BuildContext context) async => await Navigator.of(context)
    .pushNamed(YearsCalendarPage.routeName)
    .then(
      (res) {
        if (res != null) {
          final result = res as List;
          if (_now.year == result[0] && _now.month == result[1]) {
            _selectedDay = DateTime(_now.year, _now.month, _now.day);
          } else {
            _selectedDay = DateTime(result[0], result[1], 1);
          }
          _calendarController.setSelectedDay(_selectedDay, runCallback: true);
        }
      }
    );

  @override
  Widget build(BuildContext context) {
    final SettingProvider provider = Provider.of<SettingProvider>(context);
    final EventProvider eventProvider = Provider.of<EventProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
          .collection(Configs.collection_event)
          .orderBy("date", descending: true)
          .orderBy("time", descending: false)
          .orderBy("price", descending: true)
          .orderBy("subject", descending: false)
          .orderBy("tags", descending: false)
          .snapshots(),
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return _buildBody(context);
          }
          _buildData(
            provider: eventProvider,
            data: snapshot.data,
            province: MAP_PROVINCE[provider.province] ?? "",
            category: MAP_CATEGORIES[provider.category] ?? "",
          );
          return _buildBody(context);
        }
      ),
    );
  }

  void _buildData({ EventProvider provider, QuerySnapshot data, String province, String category }) async {
    _events?.clear();
    _onDayEvents?.clear();
    final List<Event> _data = <Event>[];
    _events = <DateTime, List>{};
    if (data?.documents?.isNotEmpty ?? false) {
      data?.documents?.forEach((doc) {
        if (doc?.exists ?? false) {
          var dataTemp = doc.data;
          dataTemp["id"] = doc.documentID;
          final Event e = Event.fromMap(dataTemp);
          _data.add(e);
          if ((province?.isNotEmpty ?? false) || (category?.isNotEmpty ?? false)) {
            if (!e.province.contains(province ?? "") || !e.category.contains(category ?? "")) return;
          }
          final DateTime _date = DateTime(e.date.year, e.date.month, e.date.day);
          if (_events[_date] == null) _events[_date] = [];
          _events[_date].add(e);
          print(e.date.toString());
        }
      });
    }
    _onDayEvents = _events[_selectedDay] ?? [];
    provider.events = _data;
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only( bottom: 8.0 ),
          child: Calendar(
            controller: _calendarController,
            events: _events,
            onDaySelected: _onDaySelected,
            onVisibleDaysChanged: _onVisibleDaysChanged,
            onTitleText: () {
              _selection(context);
            },
            onIcon1: () async {
              await showSearch<Event>(
                context: context,
                delegate: SearchEventDelegate(),
              );
            },
            onIcon2: () async => await Navigator.of(context).pushNamed(SettingEventPage.routeName),
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
                    padding: EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                    ),
                    child: Icon(
                      Icons.arrow_drop_down,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 8.0,
                    right: 8.0,
                  ),
                  child: Text(
                    "${_selectedDay?.year} - ${_selectedDay?.month.toString().padLeft(2, "0")} - ${_selectedDay?.day.toString().padLeft(2, "0")}",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 8.0,
                    right: 8.0,
                  ),
                  child: Icon(
                    _arrow_icon ?? Icons.arrow_drop_down,
                  ),
                ),
              ],
            ),
            onPressed: () {
              _arrow_icon = (_calendarController?.calendarFormat ?? CalendarFormat.month) == CalendarFormat.month
                ? Icons.arrow_drop_down
                : Icons.arrow_drop_up;
              _calendarController?.toggleCalendarFormat();
              setState(() {});
            },
          ),
        ),
        EventView(
          events: _onDayEvents ?? [],
          onClick: (Event data) async => await Navigator.of(context).pushNamed(EventDetailPage.routeName, arguments: data),
        ),
      ],
    );
  }

}
