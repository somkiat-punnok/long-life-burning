import 'dart:core';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:long_life_burning/utils/helper/constants.dart' show SizeConfig;
import 'package:long_life_burning/modules/calendar/calendar.dart';

class Calendar extends StatelessWidget {

  final CalendarController controller;
  final Map<DateTime, List> events;
  final OnDaySelected onDaySelected;
  final OnHeader onTitleText;
  final OnHeader onIcon1;
  final OnHeader onIcon2;
  final OnVisibleDaysChanged onVisibleDaysChanged;

  Calendar({
    Key key,
    @required this.controller,
    this.events,
    this.onDaySelected,
    this.onTitleText,
    this.onIcon1,
    this.onIcon2,
    this.onVisibleDaysChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarController: controller,
      locale: 'en_US',
      events: events,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.none,
      availableCalendarFormats: {
        CalendarFormat.month: 'Month',
        CalendarFormat.week: 'Week',
      },
      onDaySelected: onDaySelected,
      onTitleText: onTitleText,
      onIcon1: onIcon1,
      onIcon2: onIcon2,
      onVisibleDaysChanged: onVisibleDaysChanged,
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        outsideStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,),
        outsideWeekendStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold,),
        weekdayStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,),
        weekendStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold,),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        dowTextBuilder: (date, locale) => SizeConfig.screenWidth < 400
            ? DateFormat.E(locale).format(date).substring(0, 1).toUpperCase()
            : DateFormat.E(locale).format(date).substring(0, 3).toUpperCase(),
        weekdayStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,),
        weekendStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold,),
      ),
      headerStyle: HeaderStyle(
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        rightPadding1: EdgeInsets.all(SizeConfig.setWidth(12.0)),
        rightPadding2: EdgeInsets.all(SizeConfig.setWidth(12.0)),
        rightMargin1: EdgeInsets.symmetric(
          horizontal: SizeConfig.setWidth(2.0),
        ),
        rightMargin2: EdgeInsets.symmetric(
          horizontal: SizeConfig.setWidth(2.0),
        ),
        rightIcon1: Icon(
          Icons.search,
          color: Colors.black,
        ),
        rightIcon2: Icon(
          Icons.tune,
          color: Colors.black,
        ),
      ),
      builders: CalendarBuilders(
        todayDayBuilder: (context, date, events) {
          return Center(
            child: Text(
              '${date.day}',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
        markersBuilder: (context, date, events) {
          return [
            Container(
              width: 5,
              height: 5,
              margin: EdgeInsets.all(1.0),
              decoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
            )
          ];
        },
        selectedDayBuilder: (context, date, events) {
          return Container(
            width: 100,
            height: 100,
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color:  controller.isToday(date) ? Colors.red : Colors.black,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${date.day}',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}