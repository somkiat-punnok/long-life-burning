part of calendar;

class YearsCalendar extends StatelessWidget {

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

  YearView _getYearView(int year, bool isToyear) {
    return YearView(
      context: context,
      year: year,
      isToyear: isToyear,
      todayColor: todayColor,
      monthNames: monthNames,
      onMonthTap: onMonthTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final int _itemCount = lastDate.year - firstDate.year + 1;
    final double _initialOffset = (initialDate.year - firstDate.year) * getYearViewHeight(context);
    final ScrollController _scrollController = ScrollController(initialScrollOffset: _initialOffset);
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 16.0),
      controller: _scrollController,
      itemCount: _itemCount,
      itemBuilder: (BuildContext context, int index) {
        final int year = index + firstDate.year;
        final bool isToyear = dateIsToyear(DateTime(year));
        return _getYearView(year, isToyear);
      },
    );
  }
  
}
