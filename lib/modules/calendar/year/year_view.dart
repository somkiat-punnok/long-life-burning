import 'package:flutter/material.dart';
import 'package:long_life_burning/modules/calendar/utils/dates.dart';
import 'package:long_life_burning/modules/calendar/utils/screen_sizes.dart';
import 'package:long_life_burning/modules/calendar/month/month_view.dart';
import 'package:long_life_burning/modules/calendar/year/year_title.dart';

class YearView extends StatelessWidget {
  const YearView({
    @required this.context,
    @required this.year,
    this.isToyear,
    this.todayColor,
    this.monthNames,
    this.onMonthTap,
  });

  final BuildContext context;
  final int year;
  final bool isToyear;
  final Color todayColor;
  final List<String> monthNames;
  final Function onMonthTap;
  double get horizontalMargin => 16.0;
  double get monthViewPadding => 8.0;

  Widget buildYearMonths(BuildContext context) {
    final List<Row> monthRows = <Row>[];
    final List<MonthView> monthRowChildren = <MonthView>[];

    for (int month = 1; month <= DateTime.monthsPerYear; month++) {
      final bool isTomonth = dateIsTomonth(DateTime(year, month));
      monthRowChildren.add(
        MonthView(
          context: context,
          year: year,
          month: month,
          padding: monthViewPadding,
          isTomonth: isTomonth,
          todayColor: todayColor,
          monthNames: monthNames,
          onMonthTap: onMonthTap,
        ),
      );

      if (month % 3 == 0) {
        monthRows.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List<MonthView>.from(monthRowChildren),
          ),
        );
        monthRowChildren.clear();
      }
    }

    return Column(
      children: List<Row>.from(monthRows),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getYearViewHeight(context),
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: horizontalMargin,
              vertical: 0.0,
            ),
            child: YearTitle(
              year: year,
              isToyear: isToyear,
              toyearColor: todayColor,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: horizontalMargin,
              right: horizontalMargin,
              top: 8.0,
            ),
            child: Divider(
              color: Colors.black26,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: horizontalMargin - monthViewPadding,
              vertical: 0.0,
            ),
            child: buildYearMonths(context),
          ),
        ],
      ),
    );
  }
}
