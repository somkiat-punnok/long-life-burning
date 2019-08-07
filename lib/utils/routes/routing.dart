library routing;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:long_life_burning/pages/all.dart';
import '../icons.dart';
import '../constants.dart';

part 'route.dart';
part 'navigator.dart';

enum CategoryPage { stepCount, nearby, events, groups, others }

final List<NavCategory> nav = [
  kStepCount,
  kNearby,
  kEvents,
  kGroups,
  kOthers,
];

final NavCategory kStepCount = NavCategory(
  name: 'Step Count',
  icon: isMaterial ? IconsAndroid.home : IconsiOS.home,
  tag: CategoryPage.stepCount,
);

final NavCategory kNearby = NavCategory(
  name: 'Nearby',
  icon: isMaterial ? IconsAndroid.near_me : IconsiOS.near_me,
  tag: CategoryPage.nearby,
);

final NavCategory kEvents = NavCategory(
  name: 'Events',
  icon: isMaterial ? IconsAndroid.marathon : IconsiOS.marathon,
  tag: CategoryPage.events,
);

final NavCategory kGroups = NavCategory(
  name: 'Groups',
  icon: isMaterial ? IconsAndroid.group : IconsiOS.group,
  tag: CategoryPage.groups,
);

final NavCategory kOthers = NavCategory(
  name: 'Others',
  icon: isMaterial ? IconsAndroid.others : IconsiOS.others,
  tag: CategoryPage.others,
);
