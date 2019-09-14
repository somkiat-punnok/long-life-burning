part of calendar;

class MonthTitle extends StatelessWidget {

  const MonthTitle({
    @required this.month,
    this.monthNames,
    this.isTomonth,
    this.tomonthColor = Colors.blue,
  });

  final int month;
  final List<String> monthNames;
  final bool isTomonth;
  final Color tomonthColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        getMonthName(month, monthNames: monthNames),
        style: TextStyle(
          color: isTomonth ? tomonthColor : Colors.black,
          fontSize: screenSize(context) == ScreenSizes.small ? 20.0 : 24.0,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
        overflow: TextOverflow.fade,
        softWrap: false,
      ),
    );
  }
  
}
