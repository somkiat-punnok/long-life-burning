part of calendar;

class MonthView extends StatelessWidget {

  MonthView({
    @required this.context,
    @required this.year,
    @required this.month,
    @required this.padding,
    this.isTomonth,
    this.todayColor,
    this.monthNames,
    this.onMonthTap,
  });

  final BuildContext context;
  final int year;
  final int month;
  final double padding;
  final bool isTomonth;
  final Color todayColor;
  final List<String> monthNames;
  final Function onMonthTap;

  Widget buildMonthDays(BuildContext context) {
    final List<Row> dayRows = <Row>[];
    final DateTime first = DateTime(year, month, 1);
    final int firstWeekdayOfMonth = first.weekday;
    final int daysBefore = firstWeekdayOfMonth % 7;
    final DateTime firstToDisplay = first.subtract(Duration(days: daysBefore));
    final DateTime date = month < 12 ? DateTime.utc(year, month + 1, 1, 12) : DateTime.utc(year + 1, 1, 1, 12);
    final DateTime last = date.subtract(Duration(days: 1));
    int daysAfter = 7 - last.weekday;
    if (daysAfter == 0) {
      daysAfter = 7;
    }
    final DateTime lastToDisplay = last.add(Duration(days: daysAfter));
    final List<DateTime> daysInMonth = Utils.daysInRange(firstToDisplay, lastToDisplay).toList();
    final daysInWeek = 7;
    int x = 0;
    while (x < daysInMonth.length) {
      List<DateTime> list = daysInMonth.skip(x).take(daysInWeek).toList();
      if (list.length % daysInWeek == 0) {
        dayRows.add(_buildRow(list, x));
      }
      x += daysInWeek;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: dayRows,
    );
  }

  Row _buildRow(List<DateTime> days, int i) {
    return Row(
      children: days.map((DateTime date) {
        final bool isToday = dateIsToday(DateTime(date.year, date.month, date.day));
        int day = 0;
        if ((i == 0 && date.day > 10) || (i > 20 && date.day < 10)) {
          day = 0;
        }
        else {
          day = date.day;
        }
        return DayNumber(
          day: day,
          isToday: isToday,
          todayColor: todayColor,
        );
      }).toList()
    );
  }

  Widget buildMonthView(BuildContext context) {
    return Container(
      width: 7 * getDayNumberSize(context),
      margin: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MonthTitle(
            month: month,
            monthNames: monthNames,
            isTomonth: isTomonth,
            tomonthColor: todayColor,
          ),
          Container(
            margin: EdgeInsets.only(top: 8.0),
            child: buildMonthDays(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return onMonthTap == null
      ? Container(
          child: buildMonthView(context),
        )
      : InkWell(
          onTap: () => onMonthTap(year, month),
          child: buildMonthView(context),
        );
  }
  
}
