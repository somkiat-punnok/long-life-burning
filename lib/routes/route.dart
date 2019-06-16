import 'package:flutter/widgets.dart';
import 'package:long_life_burning/contents/content.dart';
import 'package:long_life_burning/screen/index.dart';
// Page
import 'package:long_life_burning/pages/about/view.dart';
import 'package:long_life_burning/pages/announce/view.dart';
import 'package:long_life_burning/pages/chart/view.dart';
import 'package:long_life_burning/pages/group/view.dart';
import 'package:long_life_burning/pages/nearby/view.dart';
import 'package:long_life_burning/pages/notify/view.dart';
import 'package:long_life_burning/pages/stepcount/view.dart';

class Routes {

  static Map<String, WidgetBuilder> route = {
    Content.Index_Page: (context) => Index(),
    Content.About_Page: (context) => AboutView(),
    Content.Announce_Page: (context) => AnnounceView(),
    Content.Chart_Page: (context) => ChartView(),
    Content.Group_Page: (context) => GroupView(),
    Content.Nearby_Page: (context) => NearbyView(),
    Content.Notify_Page: (context) => NotifyView(),
    Content.StepCount_Page: (context) => StepCountView(),
  };

  static final List<Widget> page = [
    StepCountView(),
    NearbyView(),
    AnnounceView(),
    GroupView(),
    AboutView()
  ];

}
