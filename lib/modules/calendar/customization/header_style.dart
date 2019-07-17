import 'package:flutter/material.dart';

import 'package:long_life_burning/modules/calendar/table_calendar.dart';

/// Class containing styling and configuration of `TableCalendar`'s header.
class HeaderStyle {
  /// Responsible for making title Text centered.
  final bool centerHeaderTitle;

  /// Use to customize header's title text (eg. with different `DateFormat`).
  /// You can use `String` transformations to further customize the text.
  /// Defaults to simple `'yMMMM'` format (eg. January 2019, February 2019, March 2019, etc.).
  ///
  /// Example usage:
  /// ```dart
  /// titleTextBuilder: (date, locale) => DateFormat.yM(locale).format(date),
  /// ```
  final TextBuilder titleTextBuilder;

  /// Style for title Text (month-year) displayed in header.
  final TextStyle titleTextStyle;

  /// Inside Padding for left chevron.
  final EdgeInsets leftChevronPadding;

  /// Inside Padding for right chevron.
  final EdgeInsets rightChevronPadding;

  /// Outside Margin for left chevron.
  final EdgeInsets leftChevronMargin;

  /// Outside Margin for right chevron.
  final EdgeInsets rightChevronMargin;

  /// Icon used for left chevron.
  /// Defaults to black `Icons.chevron_left`.
  final Icon leftChevronIcon;

  /// Icon used for right chevron.
  /// Defaults to black `Icons.chevron_right`.
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
