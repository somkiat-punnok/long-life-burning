part of calendar;

class DayNumber extends StatelessWidget {
  DayNumber({
    @required this.day,
    this.isToDay,
    this.toDayColor = Colors.blue,
  });

  final int day;
  final bool isToDay;
  final Color toDayColor;

  @override
  Widget build(BuildContext context) {
    final double size = getDayNumberSize();
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: day > 0 && isToDay
          ? BoxDecoration(
              color: toDayColor,
              borderRadius: BorderRadius.circular(size / 2),
            )
          : null,
      child: Text(
        day < 1 ? '' : day.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isToDay ? Colors.white : Colors.black,
          fontSize: screenSize() == ScreenSizes.small ? 8.0 : 10.0,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
