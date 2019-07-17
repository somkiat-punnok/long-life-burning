import 'package:flutter/material.dart';
import 'package:long_life_burning/modules/calendar/utils/screen_sizes.dart';

class YearTitle extends StatelessWidget {
  const YearTitle({
    this.year,
    this.isToyear,
    this.toyearColor = Colors.blue,
  });

  final int year;
  final bool isToyear;
  final Color toyearColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      year.toString(),
      style: TextStyle(
        color: isToyear ? toyearColor : Colors.black,
        fontSize: screenSize(context) == ScreenSizes.small ? 22.0 : 26.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
