import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:long_life_burning/constants/constant.dart';
import 'package:long_life_burning/screen/index.dart';
// Page
import 'package:long_life_burning/pages/about/view.dart';
import 'package:long_life_burning/pages/announce/view.dart';
import 'package:long_life_burning/pages/chart/view.dart';
import 'package:long_life_burning/pages/common/year.dart';
import 'package:long_life_burning/pages/group/view.dart';
import 'package:long_life_burning/pages/nearby/view.dart';
import 'package:long_life_burning/pages/notify/view.dart';
import 'package:long_life_burning/pages/stepcount/view.dart';
import 'package:long_life_burning/pages/stepcount/record_view.dart';

class Routes {

  // Page route
  static Map<String, WidgetBuilder> route = {
    Constants.Index_Page: (context) => Index(),
    Constants.About_Page: (context) => AboutView(),
    Constants.Announce_Page: (context) => AnnounceView(),
    Constants.Years_Page: (context) => YearsCalendarView(),
    Constants.Chart_Page: (context) => ChartView(),
    Constants.Group_Page: (context) => GroupView(),
    Constants.Nearby_Page: (context) => NearbyView(),
    Constants.Notify_Page: (context) => NotifyView(),
    Constants.StepCount_Page: (context) => StepCountView(),
    Constants.Record_Page: (context) => RecordView(),
  };

  // Page view on navBar
  static final List<Widget> pageNavBar = [
    StepCountView(),
    NearbyView(),
    AnnounceView(),
    GroupView(),
    AboutView()
  ];

}
