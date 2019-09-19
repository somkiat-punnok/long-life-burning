part of calendar;

class YearView extends StatelessWidget {
  YearView({
    @required this.context,
    @required this.year,
    this.isToYear,
    this.toDayColor,
    this.monthNames,
    this.onMonthTap,
  });

  final BuildContext context;
  final int year;
  final bool isToYear;
  final Color toDayColor;
  final List<String> monthNames;
  final Function onMonthTap;
  double get horizontalMargin => 8.0;
  double get monthViewPadding => 8.0;

  Widget buildYearMonths(BuildContext context) {
    final List<Row> monthRows = <Row>[];
    final List<MonthView> monthRowChildren = <MonthView>[];
    for (int month = 1; month <= DateTime.monthsPerYear; month++) {
      final bool isToMonth = dateIsTomonth(DateTime(year, month));
      monthRowChildren.add(
        MonthView(
          context: context,
          year: year,
          month: month,
          padding: monthViewPadding,
          isToMonth: isToMonth,
          toDayColor: toDayColor,
          monthNames: monthNames,
          onMonthTap: onMonthTap,
        ),
      );
      if (month % 3 == 0) {
        monthRows.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
      height: getYearViewHeight(),
      padding: EdgeInsets.only(top: 16.0),
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
              isToYear: isToYear,
              toYearColor: toDayColor,
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
              horizontal: 0.0,
              vertical: 0.0,
            ),
            child: buildYearMonths(context),
          ),
        ],
      ),
    );
  }
}
