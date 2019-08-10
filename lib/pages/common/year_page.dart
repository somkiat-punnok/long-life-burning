import 'package:flutter/material.dart';
import 'package:long_life_burning/modules/calendar/calendar.dart' show YearsCalendar;

class YearsCalendarPage extends StatefulWidget {
  static const String routeName = '/year';
  @override
  _YearsCalendarPageState createState() => _YearsCalendarPageState();
}

class _YearsCalendarPageState extends State<YearsCalendarPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: SafeArea(
        child: Center(
          child: YearsCalendar(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 5 * 365)),
            lastDate: DateTime.now().add(Duration(days: 5 * 365)),
            todayColor: Colors.red,
            onMonthTap: (int year, int month) async {
              Navigator.pop(
                context,
                <int>[
                  year,
                  month,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
  
}