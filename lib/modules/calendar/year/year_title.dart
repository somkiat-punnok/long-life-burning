part of calendar;

class YearTitle extends StatelessWidget {
  const YearTitle({
    this.year,
    this.isToYear,
    this.toYearColor = Colors.blue,
  });

  final int year;
  final bool isToYear;
  final Color toYearColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      year.toString(),
      style: TextStyle(
        color: isToYear ? toYearColor : Colors.black,
        fontSize: screenSize() == ScreenSizes.small ? 36.0 : 40.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
