import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
//import 'package:date_utils/date_utils.dart';
//import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'package:long_life_burning/modules/calendar/table_calendar.dart';

typedef void OnDaySelected(DateTime day, List events);
typedef void OnVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format);

class Calendar extends StatefulWidget {

  final Map<DateTime, List> events;
  final DateTime selectedDay;
  final List selectedEvents;
  final OnDaySelected onDaySelected;
  final OnVisibleDaysChanged onVisibleDaysChanged;

  Calendar({
    Key key,
    this.events,
    this.selectedDay,
    this.selectedEvents,
    this.onDaySelected,
    this.onVisibleDaysChanged,
  }) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'en_US',
      events: widget.events,
      selectedDay: widget.selectedDay,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.verticalSwipe,
      availableCalendarFormats: {
        CalendarFormat.month: 'Month',
        CalendarFormat.week: 'Week',
      },
      onDaySelected: widget.onDaySelected,
      onVisibleDaysChanged: widget.onVisibleDaysChanged,
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        outsideWeekendStyle: TextStyle(color: Colors.grey),
        weekdayStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,),
        weekendStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500,),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        dowTextBuilder: (date, locale) {
          return DateFormat.E(locale).format(date).substring(0, 3).toUpperCase();
        },
        weekdayStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,),
        weekendStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500,),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        titleTextStyle: TextStyle(color: Colors.black),
      ),
      builders: CalendarBuilders(
        todayDayBuilder: (context, date, events) {
          return Center(
            child: Text(
              '${date.day}',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.red,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        },
        markersBuilder: (context, date, events) {
          return [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
              margin: EdgeInsets.all(4.0),
              width: 5,
              height: 5,
            )
          ];
        },
        selectedDayBuilder: (context, date, events) {

          if(date.day == DateTime.now().day && date.month == DateTime.now().month && date.year == DateTime.now().year) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              margin: EdgeInsets.all(12.0),
              width: 100,
              height: 100,
              child: Center(
                child: Text(
                  '${date.day}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }

          return Container(
            decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            margin: EdgeInsets.all(12.0),
            width: 100,
            height: 100,
            child: Center(
              child: Text(
                '${date.day}',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // DateTime _selectedDay;
  // Map<DateTime, List> _visibleEvents;
  // List _selectedEvents;
  // AnimationController _controller;

  // @override
  // void initState() {
  //   super.initState();
  //   _selectedDay = DateTime.now();
  //   _selectedEvents = Event.events[_selectedDay] ?? [];
  //   _visibleEvents = Event.events;

  //   _controller = AnimationController(
  //     vsync: this,
  //     duration: const Duration(milliseconds: 400),
  //   );

  //   _controller.forward();
  // }

  // void _onDaySelected(DateTime day, List events) {
  //   setState(() {
  //     _selectedDay = day;
  //     _selectedEvents = events;
  //   });
  // }

  // void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
  //   setState(() {
  //     _visibleEvents = Map.fromEntries(
  //       Event.events.entries.where(
  //         (entry) =>
  //             entry.key.isAfter(first.subtract(const Duration(days: 1))) &&
  //             entry.key.isBefore(last.add(const Duration(days: 1))),
  //       ),
  //     );
  //   });
  // }

  // Widget _buildTableCalendar() {
  //   return TableCalendar(
  //     locale: 'en_US',
  //     events: _visibleEvents,
  //     initialCalendarFormat: CalendarFormat.month,
  //     formatAnimation: FormatAnimation.slide,
  //     startingDayOfWeek: StartingDayOfWeek.sunday,
  //     availableGestures: AvailableGestures.all,
  //     availableCalendarFormats: const {
  //       CalendarFormat.month: 'Month',
  //       CalendarFormat.week: 'Week',
  //     },
  //     calendarStyle: CalendarStyle(
  //       selectedColor: Colors.deepOrange[400],
  //       todayColor: Colors.deepOrange[200],
  //       markersColor: Colors.brown[700],
  //     ),
  //     headerStyle: HeaderStyle(
  //       formatButtonTextStyle: TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
  //       formatButtonDecoration: BoxDecoration(
  //         color: Colors.deepOrange[400],
  //         borderRadius: BorderRadius.circular(16.0),
  //       ),
  //     ),
  //     onDaySelected: _onDaySelected,
  //     onVisibleDaysChanged: _onVisibleDaysChanged,
  //   );
  // }

  // More advanced TableCalendar configuration (using Builders & Styles)
  // Widget _buildTableCalendarWithBuilders() {
  //   return TableCalendar(
  //     locale: 'en_US',
  //     events: _visibleEvents,
  //     initialCalendarFormat: CalendarFormat.month,
  //     formatAnimation: FormatAnimation.slide,
  //     startingDayOfWeek: StartingDayOfWeek.sunday,
  //     availableGestures: AvailableGestures.all,
  //     availableCalendarFormats: {
  //       CalendarFormat.month: '',
  //       CalendarFormat.week: '',
  //     },
  //     calendarStyle: CalendarStyle(
  //       selectedColor: Colors.deepOrange[400],
  //       todayColor: Colors.deepOrange[200],
  //       weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
  //     ),
  //     daysOfWeekStyle: DaysOfWeekStyle(
  //       weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
  //     ),
  //     headerStyle: HeaderStyle(
  //       centerHeaderTitle: true,
  //       formatButtonVisible: false,
  //       formatButtonTextStyle: TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
  //       formatButtonDecoration: BoxDecoration(
  //         color: Colors.deepOrange[400],
  //         borderRadius: BorderRadius.circular(16.0),
  //       ),
  //     ),
  //     builders: CalendarBuilders(
  //       selectedDayBuilder: (context, date, _) {
  //         return FadeTransition(
  //           opacity: Tween(begin: 0.0, end: 1.0).animate(_controller),
  //           child: Container(
  //             margin: EdgeInsets.all(4.0),
  //             padding: EdgeInsets.only(top: 5.0, left: 6.0),
  //             color: Colors.deepOrange[300],
  //             width: 100,
  //             height: 100,
  //             child: Text(
  //               '${date.day}',
  //               style: TextStyle().copyWith(fontSize: 16.0),
  //             ),
  //           ),
  //         );
  //       },
  //       todayDayBuilder: (context, date, _) {
  //         return Container(
  //           margin: EdgeInsets.all(4.0),
  //           padding: EdgeInsets.only(top: 5.0, left: 6.0),
  //           color: Colors.amber[400],
  //           width: 100,
  //           height: 100,
  //           child: Text(
  //             '${date.day}',
  //             style: TextStyle().copyWith(fontSize: 16.0),
  //           ),
  //         );
  //       },
  //       markersBuilder: (context, date, events) {
  //         final children = <Widget>[];

  //         if (events.isNotEmpty) {
  //           children.add(
  //             Positioned(
  //               right: 1,
  //               bottom: 1,
  //               child: _buildEventsMarker(date, events),
  //             ),
  //           );
  //         }

  //         return children;
  //       },
  //     ),
  //     onDaySelected: (date, events) {
  //       _onDaySelected(date, events);
  //       _controller.forward(from: 0.0);
  //     },
  //     onVisibleDaysChanged: _onVisibleDaysChanged,
  //   );
  // }

  // Widget _buildEventsMarker(DateTime date, List events) {
  //   return AnimatedContainer(
  //     duration: const Duration(milliseconds: 300),
  //     decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       color: Utils.isSameDay(date, _selectedDay)
  //           ? Colors.brown[500]
  //           : Utils.isSameDay(date, DateTime.now()) ? Colors.brown[300] : Colors.blue[400],
  //     ),
  //     width: 16.0,
  //     height: 16.0,
  //     child: Center(
  //       child: Text(
  //         '${events.length}',
  //         style: TextStyle().copyWith(
  //           color: Colors.white,
  //           fontSize: 12.0,
  //         ),
  //       ),
  //     ),
  //   );
  // }

}