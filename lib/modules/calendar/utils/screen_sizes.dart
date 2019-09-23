part of calendar;

enum ScreenSizes {
  small,
  medium,
  large,
}

ScreenSizes screenSize() {
  final double width = SizeConfig.screenWidth;
  if (width < 340) {
    return ScreenSizes.small;
  } else if (width < 540) {
    return ScreenSizes.medium;
  } else {
    return ScreenSizes.large;
  }
}

double getDayNumberSize() {
  return screenSize() == ScreenSizes.small ? 12.0 : 14.0;
}

double getMonthViewHeight() {
  const double padding = 8.0;
  final double titleHeight = screenSize() == ScreenSizes.small ? 22.0 : 24.0;
  return (2 * padding) + titleHeight + 8.0 + (6 * getDayNumberSize());
}

double getYearViewHeight() {
  final double topPadding = screenSize() == ScreenSizes.small ? 8.0 : 16.0;
  final double titleHeight = screenSize() == ScreenSizes.small ? 42.0 : 44.0;
  final double dividerHeight = screenSize() == ScreenSizes.small ? 8.0 : 16.0;
  return topPadding + titleHeight + 8.0 + dividerHeight + (4 * getMonthViewHeight() - getDayNumberSize());
}
