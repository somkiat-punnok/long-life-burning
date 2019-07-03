import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:long_life_burning/modules/announce/events.dart';
import 'package:long_life_burning/modules/announce/calendar.dart';
import 'package:long_life_burning/modules/calendar/table_calendar.dart';
//import 'package:long_life_burning/constants/platform.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Calendar(
            events: _events,
            selectedDay: _selectedDay,
            selectedEvents: _selectedEvents,
            onDaySelected: _onDaySelected,
            onVisibleDaysChanged: _onVisibleDaysChanged,
          ),
          EventList(
            events: _selectedEvents,
          ),
        ],
      ),
    );
  }

  // Widget _buildEventList() {
  //   return ListView(
  //     children: _selectedEvents
  //         .map((event) => Container(
  //               decoration: BoxDecoration(
  //                 border: Border.all(width: 0.8),
  //                 borderRadius: BorderRadius.circular(12.0),
  //               ),
  //               margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
  //               child: ListTile(
  //                 title: Text(event.toString()),
  //                 onTap: () => print('$event tapped!'),
  //               ),
  //             ))
  //         .toList(),
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
    
  //   if ( Platforms.isIOS ) {
  //     return IOSScaffold(
  //       appBar: IOSAppBar(
  //         title: Text(
  //           'Announce',
  //           style: TextStyle(color: Colors.white),
  //         ),
  //         backgroundColor: Colors.black,
  //       ),
  //       backgroundColor: Colors.black87,
  //       body: Center(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             Text(
  //               'Announce Page',
  //               style: TextStyle(color: Colors.white),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   }

  //   return AndroidScaffold(
  //     appBar:  AndroidAppBar(
  //       title: Text(
  //         'Announce',
  //         style: TextStyle(color: Colors.white),
  //       ),
  //       backgroundColor: Colors.black,
  //     ),
  //     backgroundColor: Colors.black87,
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Text(
  //             'Announce Page',
  //             style: TextStyle(color: Colors.white),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );

  // }

}