library calendar;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:long_life_burning/utils/constants.dart';
import 'package:long_life_burning/utils/widgets/date_utils.dart';
import 'package:long_life_burning/utils/widgets/gesture_detector.dart';

part 'calendar_controller.dart';
part 'table_calendar.dart';
part 'years_calendar.dart';
part 'customization/calendar_builders.dart';
part 'customization/calendar_style.dart';
part 'customization/days_of_week_style.dart';
part 'customization/header_style.dart';
part 'day/day_number.dart';
part 'month/month_title.dart';
part 'month/month_view.dart';
part 'utils/dates.dart';
part 'utils/screen_sizes.dart';
part 'widgets/cell_widget.dart';
part 'widgets/custom_icon_button.dart';
part 'year/year_title.dart';
part 'year/year_view.dart';

const double _dxMax = 1.2;
const double _dxMin = -1.2;

typedef String TextBuilder(DateTime date, dynamic locale);
typedef void OnDaySelected(DateTime day, List events);
typedef void OnVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format);
typedef void OnHeader();
typedef void _SelectedDayCallback(DateTime day);

typedef FullBuilder = Widget Function(BuildContext context, DateTime date, List events);
typedef FullListBuilder = List<Widget> Function(BuildContext context, DateTime date, List events);

enum CalendarFormat {
  month,
  week,
}

enum StartingDayOfWeek {
  monday,
  sunday,
}

enum AvailableGestures {
  none,
  verticalSwipe,
  horizontalSwipe,
  all,
}
