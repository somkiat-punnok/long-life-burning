import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:long_life_burning/pages/all.dart';
import 'navigator.dart';
import '../icons.dart';
import '../constants.dart';

List<Pages> get allPage => _buildPage();

List<CategoryPage> get categoriesPage => CategoryPage.values.toList();

Map<CategoryPage, List<Pages>> get listPageCategory => Map<CategoryPage, List<Pages>>.fromIterable(
  categoriesPage,
  value: (dynamic tag) {
    return allPage.where((Pages page) => page.tag == tag).toList();
  },
);

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

List<Pages> _buildPage() {
  return <Pages>[
    Pages(
      name: kStepCount.name,
      tag: CategoryPage.stepCount,
      routeName: StepCountPage.routeName,
      buildRoute: (BuildContext context) => StepCountPage(),
    ),
    Pages(
      name: kNearby.name,
      tag: CategoryPage.nearby,
      routeName: NearbyPage.routeName,
      buildRoute: (BuildContext context) => NearbyPage(),
    ),
    Pages(
      name: kEvents.name,
      tag: CategoryPage.events,
      routeName: AnnouncePage.routeName,
      buildRoute: (BuildContext context) => AnnouncePage(),
    ),
    Pages(
      name: kGroups.name,
      tag: CategoryPage.groups,
      routeName: GroupPage.routeName,
      buildRoute: (BuildContext context) => GroupPage(),
    ),
    Pages(
      name: kOthers.name,
      tag: CategoryPage.others,
      routeName: OtherPage.routeName,
      buildRoute: (BuildContext context) => OtherPage(),
    ),
    Pages(
      name: 'Record',
      tag: CategoryPage.stepCount,
      routeName: RecordPage.routeName,
      buildRoute: (BuildContext context) => RecordPage(),
    ),
    Pages(
      name: 'Year Calendar',
      tag: CategoryPage.stepCount,
      routeName: YearsCalendarPage.routeName,
      buildRoute: (BuildContext context) => YearsCalendarPage(),
    ),
    Pages(
      name: 'Event Detail',
      tag: CategoryPage.events,
      routeName: EventDetailPage.routeName,
      buildRoute: (BuildContext context) => EventDetailPage(),
    ),
    Pages(
      name: 'Year Calendar',
      tag: CategoryPage.events,
      routeName: YearsCalendarPage.routeName,
      buildRoute: (BuildContext context) => YearsCalendarPage(),
    ),
    Pages(
      name: 'Notify',
      tag: CategoryPage.events,
      routeName: NotifyPage.routeName,
      buildRoute: (BuildContext context) => NotifyPage(),
    ),
    Pages(
      name: 'Chart',
      tag: CategoryPage.others,
      routeName: ChartPage.routeName,
      buildRoute: (BuildContext context) => ChartPage(),
    ),
  ];
}
