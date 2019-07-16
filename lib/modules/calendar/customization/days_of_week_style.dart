import 'package:flutter/material.dart';
import 'package:long_life_burning/modules/calendar/table_calendar.dart';

class DaysOfWeekStyle {

  final TextBuilder dowTextBuilder;
  final TextStyle weekdayStyle;
  final TextStyle weekendStyle;

  const DaysOfWeekStyle({
    this.dowTextBuilder,
    this.weekdayStyle = const TextStyle(color: const Color(0xFF616161)),
    this.weekendStyle = const TextStyle(color: const Color(0xFFF44336)),
  });
  
}
