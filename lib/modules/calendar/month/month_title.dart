part of calendar;

class MonthTitle extends StatelessWidget {
  const MonthTitle({
    @required this.month,
    this.monthNames,
    this.isToMonth,
    this.toMonthColor = Colors.blue,
  });

  final int month;
  final List<String> monthNames;
  final bool isToMonth;
  final Color toMonthColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        getMonthName(month, monthNames: monthNames),
        style: TextStyle(
          color: isToMonth ? toMonthColor : Colors.black,
          fontSize: screenSize() == ScreenSizes.small ? 20.0 : 22.0,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
        overflow: TextOverflow.fade,
        softWrap: false,
      ),
    );
  }
}
