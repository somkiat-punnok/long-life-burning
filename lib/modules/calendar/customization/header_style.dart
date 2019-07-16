import 'package:flutter/material.dart';
import 'package:long_life_burning/modules/calendar/table_calendar.dart';

class HeaderStyle {

  final bool centerHeaderTitle;
  final TextBuilder titleTextBuilder;
  final TextStyle titleTextStyle;
  final EdgeInsets leftChevronPadding;
  final EdgeInsets rightChevronPadding;
  final EdgeInsets leftChevronMargin;
  final EdgeInsets rightChevronMargin;
  final Icon leftChevronIcon;
  final Icon rightChevronIcon;

  const HeaderStyle({
    this.centerHeaderTitle = false,
    this.titleTextBuilder,
    this.titleTextStyle = const TextStyle(fontSize: 17.0),
    this.leftChevronPadding = const EdgeInsets.all(12.0),
    this.rightChevronPadding = const EdgeInsets.all(12.0),
    this.leftChevronMargin = const EdgeInsets.symmetric(horizontal: 8.0),
    this.rightChevronMargin = const EdgeInsets.symmetric(horizontal: 8.0),
    this.leftChevronIcon = const Icon(Icons.chevron_left, color: Colors.black),
    this.rightChevronIcon = const Icon(Icons.chevron_right, color: Colors.black),
  });
  
}
