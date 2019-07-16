import 'package:flutter/material.dart';

enum ScreenSizes {
  small,
  medium,
  large,
}

ScreenSizes screenSize(BuildContext context) {
  final double width = MediaQuery.of(context).size.width;
  if (width < 340) {
    return ScreenSizes.small;
  } else if (width < 540) {
    return ScreenSizes.medium;
  } else {
    return ScreenSizes.large;
  }
}

double getDayNumberSize(BuildContext context) {
  return screenSize(context) == ScreenSizes.small ? 12.0 : 16.0;
}

double getMonthViewHeight(BuildContext context) {
  const double padding = 8.0;
  const double titleHeight = 21.0;
  return (2 * padding) + titleHeight + 8.0 + (6 * getDayNumberSize(context));
}

double getYearViewHeight(BuildContext context) {
  const double topPadding = 16.0;
  final double titleHeight = screenSize(context) == ScreenSizes.small ? 26.0 : 30.0;
  const double dividerHeight = 16.0;
  return topPadding + titleHeight + 8.0 + dividerHeight + (4 * getMonthViewHeight(context) - getDayNumberSize(context));
}
