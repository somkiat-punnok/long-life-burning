import 'package:flutter/widgets.dart';
// Modules
import 'package:long_life_burning/pages/about/view.dart';
import 'package:long_life_burning/pages/announce/view.dart';
//import 'package:long_life_burning/pages/chart/view.dart';
import 'package:long_life_burning/pages/group/view.dart';
import 'package:long_life_burning/pages/nearby/view.dart';
//import 'package:long_life_burning/pages/notify/view.dart';
import 'package:long_life_burning/pages/stepcount/view.dart';

class Routes {

  static final List<Widget> pageNavBar = [
    StepCountView(),
    NearbyView(),
    AnnounceView(),
    GroupView(),
    AboutView()
  ];

}
