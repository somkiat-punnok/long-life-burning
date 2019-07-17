import 'package:flutter/material.dart';
import 'package:long_life_burning/modules/calendar/utils/dates.dart';
import 'package:long_life_burning/modules/calendar/utils/screen_sizes.dart';
import 'package:long_life_burning/modules/calendar/year/year_view.dart';

class YearsCalendar extends StatefulWidget {
  YearsCalendar({
    @required this.context,
    @required this.initialDate,
    @required this.firstDate,
    @required this.lastDate,
    this.todayColor,
    this.monthNames,
    this.onMonthTap,
  })  : assert(context != null),
        assert(initialDate != null),
        assert(firstDate != null),
        assert(lastDate != null),
        assert(!initialDate.isBefore(firstDate), 'initialDate must be on or after firstDate'),
        assert(!initialDate.isAfter(lastDate), 'initialDate must be on or before lastDate'),
        assert(!firstDate.isAfter(lastDate), 'lastDate must be on or after firstDate'),
        assert(monthNames == null || monthNames.length == DateTime.monthsPerYear);

  final BuildContext context;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final Color todayColor;
  final List<String> monthNames;
  final Function onMonthTap;

  @override
  _YearsCalendarState createState() => _YearsCalendarState();
}

class _YearsCalendarState extends State<YearsCalendar> {
  /// Gets a widget with the view of the given year.
  YearView _getYearView(int year, bool isToyear) {
    return YearView(
      context: context,
      year: year,
      isToyear: isToyear,
      todayColor: widget.todayColor,
      monthNames: widget.monthNames,
      onMonthTap: widget.onMonthTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final int _itemCount = widget.lastDate.year - widget.firstDate.year + 1;
    final double _initialOffset = (widget.initialDate.year - widget.firstDate.year) * getYearViewHeight(context);
    final ScrollController _scrollController = ScrollController(initialScrollOffset: _initialOffset);

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16.0),
      controller: _scrollController,
      itemCount: _itemCount,
      itemBuilder: (BuildContext context, int index) {
        final int year = index + widget.firstDate.year;
        final bool isToyear = dateIsToyear(DateTime(year));
        return _getYearView(year, isToyear);
      },
    );
  }
}
