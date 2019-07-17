import 'package:flutter/material.dart';

typedef FullBuilder = Widget Function(BuildContext context, DateTime date, List events);
typedef FullListBuilder = List<Widget> Function(BuildContext context, DateTime date, List events);

class CalendarBuilders {
  
  final FullBuilder dayBuilder;
  final FullBuilder selectedDayBuilder;
  final FullBuilder todayDayBuilder;
  final FullBuilder weekendDayBuilder;
  final FullBuilder outsideDayBuilder;
  final FullBuilder outsideWeekendDayBuilder;
  final FullBuilder unavailableDayBuilder;
  final FullListBuilder markersBuilder;

  const CalendarBuilders({
    this.dayBuilder,
    this.selectedDayBuilder,
    this.todayDayBuilder,
    this.weekendDayBuilder,
    this.outsideDayBuilder,
    this.outsideWeekendDayBuilder,
    this.unavailableDayBuilder,
    this.markersBuilder,
  });
  
}
