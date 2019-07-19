import 'dart:core';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:long_life_burning/modules/calendar/table_calendar.dart';

class Calendar extends StatelessWidget {

  final Map<DateTime, List> events;
  final DateTime selectedDay;
  final OnDaySelected onDaySelected;
  final OnHeader onTitleText;
  final OnHeader onIcon1;
  final OnHeader onIcon2;
  final OnHeader onIcon3;
  final OnVisibleDaysChanged onVisibleDaysChanged;

  Calendar({
    Key key,
    this.events,
    this.selectedDay,
    this.onDaySelected,
    this.onTitleText,
    this.onIcon1,
    this.onIcon2,
    this.onIcon3,
    this.onVisibleDaysChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'en_US',
      events: events,
      selectedDay: selectedDay,
      initialCalendarFormat: CalendarFormat.month,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.verticalSwipe,
      availableCalendarFormats: {
        CalendarFormat.month: 'Month',
        CalendarFormat.week: 'Week',
      },
      onDaySelected: onDaySelected,
      onTitleText: onTitleText,
      onIcon1: onIcon1,
      onIcon2: onIcon2,
      onIcon3: onIcon3,
      onVisibleDaysChanged: onVisibleDaysChanged,
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
          return Container(
            decoration: BoxDecoration(
              color:  (date.day == DateTime.now().day && date.month == DateTime.now().month && date.year == DateTime.now().year)
                      ? Colors.red : Colors.black,
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

}