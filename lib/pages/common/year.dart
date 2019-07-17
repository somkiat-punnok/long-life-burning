import 'package:flutter/material.dart';
import 'package:long_life_burning/modules/calendar/years_calendar.dart';

class YearsCalendarView extends StatefulWidget {
  @override
  _YearsCalendarViewState createState() => _YearsCalendarViewState();
}

class _YearsCalendarViewState extends State<YearsCalendarView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: YearsCalendar(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 10 * 365)),
            lastDate: DateTime.now().add(Duration(days: 10 * 365)),
            todayColor: Colors.red,
            onMonthTap: (int year, int month) async {
              Navigator.pop(
                context,
                [ year, month, ],
              );
            },
          ),
        ),
      ),
    );
  }
}