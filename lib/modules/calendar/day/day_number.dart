part of calendar;

class DayNumber extends StatelessWidget {
  DayNumber({
    @required this.day,
    this.isToday,
    this.todayColor = Colors.blue,
  });

  final int day;
  final bool isToday;
  final Color todayColor;

  @override
  Widget build(BuildContext context) {
    final double size = getDayNumberSize(context);
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: day > 0 && isToday
        ? BoxDecoration(
            color: todayColor,
            borderRadius: BorderRadius.circular(size / 2),
          )
        : null,
      child: Text(
        day < 1 ? '' : day.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isToday ? Colors.white : Colors.black,
          fontSize: screenSize(context) == ScreenSizes.small ? 10.0 : 12.0,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
