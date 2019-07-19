import 'package:flutter/material.dart';
import 'package:long_life_burning/widgets/platform_widgets.dart';
import 'package:long_life_burning/modules/calendar/years_calendar.dart';

class YearsCalendarPage extends StatefulWidget {
  @override
  _YearsCalendarPageState createState() => _YearsCalendarPageState();
}

class _YearsCalendarPageState extends State<YearsCalendarPage> {

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      android: (_) => MaterialScaffoldData(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: true,
      ),
      ios: (_) => CupertinoPageScaffoldData(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomInsetTab: true,
      ),
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