library routing;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:long_life_burning/pages/all.dart';
import '../icons.dart';
import '../constants.dart';

part 'route.dart';
part 'navigator.dart';

enum CategoryPage { stepCount, nearby, events, groups, menu }

final List<NavCategory> nav = [
  kStepCount,
  kNearby,
  kEvents,
  kGroups,
  kMenu,
];

final NavCategory kStepCount = NavCategory(
  name: 'Step Count',
  icon: isMaterial ? IconAndroid.home : IconiOS.home,
  tag: CategoryPage.stepCount,
);

final NavCategory kNearby = NavCategory(
  name: 'Nearby',
  icon: isMaterial ? IconAndroid.near_me : IconiOS.near_me,
  tag: CategoryPage.nearby,
);

final NavCategory kEvents = NavCategory(
  name: 'Events',
  icon: isMaterial ? IconAndroid.marathon : IconiOS.marathon,
  tag: CategoryPage.events,
);

final NavCategory kGroups = NavCategory(
  name: 'Groups',
  icon: isMaterial ? IconAndroid.group : IconiOS.group,
  tag: CategoryPage.groups,
);

final NavCategory kMenu = NavCategory(
  name: 'Menu',
  icon: isMaterial ? IconAndroid.menu : IconiOS.menu,
  tag: CategoryPage.menu,
);
