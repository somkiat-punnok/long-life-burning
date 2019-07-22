import 'package:flutter/widgets.dart';
import 'package:long_life_burning/constants/constant.dart';
import 'package:long_life_burning/screen/index.dart';
import 'package:long_life_burning/pages/all.dart';

class Routes {

  // Page route
  static final Map<String, WidgetBuilder> route = {
    Constants.indexRoute: (BuildContext context) => Index(),
    Constants.aboutRoute: (BuildContext context) => AboutPage(),
    Constants.announceRoute: (BuildContext context) => AnnouncePage(),
    Constants.yearsRoute: (BuildContext context) => YearsCalendarPage(),
    Constants.chartRoute: (BuildContext context) => ChartPage(),
    Constants.groupRoute: (BuildContext context) => GroupPage(),
    Constants.nearbyRoute: (BuildContext context) => NearbyPage(),
    Constants.notifyRoute: (BuildContext context) => NotifyPage(),
    Constants.stepCountRoute: (BuildContext context) => StepCountPage(),
    Constants.recordRoute: (BuildContext context) => RecordPage(),
  };

  // Page view on navBar
  static final List<Widget> pageNavBar = [
    StepCountPage(),
    NearbyPage(),
    AnnouncePage(),
    GroupPage(),
    AboutPage(),
  ];

}
