import 'dart:core';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:long_life_burning/modules/calendar/table_calendar.dart';

typedef void OnDaySelected(DateTime day, List events);
typedef void OnVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format);
typedef void OnHeader();

class Calendar extends StatelessWidget {

  final Map<DateTime, List> records;
  final DateTime selectedDay;
  final OnDaySelected onDaySelected;
  final OnHeader onTitleText;
  final OnVisibleDaysChanged onVisibleDaysChanged;

  Calendar({
    Key key,
    this.records,
    this.selectedDay,
    this.onDaySelected,
    this.onTitleText,
    this.onVisibleDaysChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'en_US',
      events: records,
      selectedDay: selectedDay,
      initialCalendarFormat: CalendarFormat.week,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.none,
      availableCalendarFormats: {
        CalendarFormat.week: 'Week',
      },
      onDaySelected: onDaySelected,
      onTitleText: onTitleText,
      onVisibleDaysChanged: onVisibleDaysChanged,
      calendarStyle: CalendarStyle(
        outsideStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,),
        outsideWeekendStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500,),
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