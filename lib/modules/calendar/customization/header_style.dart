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
  final EdgeInsets rightPadding1;
  final EdgeInsets rightPadding2;
  final EdgeInsets rightPadding3;
  final EdgeInsets rightMargin1;
  final EdgeInsets rightMargin2;
  final EdgeInsets rightMargin3;
  final Icon rightIcon1;
  final Icon rightIcon2;
  final Icon rightIcon3;

  const HeaderStyle({
    this.centerHeaderTitle = false,
    this.titleTextBuilder,
    this.titleTextStyle = const TextStyle(fontSize: 18.0),
    this.leftChevronPadding = const EdgeInsets.all(12.0),
    this.rightChevronPadding = const EdgeInsets.all(12.0),
    this.leftChevronMargin = const EdgeInsets.symmetric(horizontal: 8.0),
    this.rightChevronMargin = const EdgeInsets.symmetric(horizontal: 8.0),
    this.leftChevronIcon = const Icon(Icons.chevron_left, color: Colors.black),
    this.rightChevronIcon = const Icon(Icons.chevron_right, color: Colors.black),
    this.rightPadding1 = const EdgeInsets.all(8.0),
    this.rightPadding2 = const EdgeInsets.all(8.0),
    this.rightPadding3 = const EdgeInsets.all(8.0),
    this.rightMargin1 = const EdgeInsets.symmetric(horizontal: 8.0),
    this.rightMargin2 = const EdgeInsets.symmetric(horizontal: 8.0),
    this.rightMargin3 = const EdgeInsets.symmetric(horizontal: 8.0),
    this.rightIcon1 = const Icon(Icons.search, color: Colors.black),
    this.rightIcon2 = const Icon(Icons.notifications, color: Colors.black),
    this.rightIcon3 = const Icon(Icons.settings, color: Colors.black),
  });
  
}
