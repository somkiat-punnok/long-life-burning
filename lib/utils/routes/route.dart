part of routing;

List<Pages> get allPage => _buildPage();

List<CategoryPage> get categoriesPage => CategoryPage.values.toList();

Map<CategoryPage, List<Pages>> get listPageCategory => Map<CategoryPage, List<Pages>>.fromIterable(
  categoriesPage,
  value: (dynamic tag) {
    return allPage.where((Pages page) => page.tag == tag).toList();
  },
);

Map<String, WidgetBuilder> _buildRoutePage(CategoryPage i) => Map<String, WidgetBuilder>.fromIterable(
  listPageCategory[i],
  key: (dynamic page) => page.routeName,
  value: (dynamic page) => page.buildRoute,
);

List<Pages> _buildPage() => <Pages>[
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
    name: 'Setting',
    tag: CategoryPage.events,
    routeName: SettingPage.routeName,
    buildRoute: (BuildContext context) => SettingPage(),
  ),
  Pages(
    name: 'Chart',
    tag: CategoryPage.others,
    routeName: ChartPage.routeName,
    buildRoute: (BuildContext context) => ChartPage(),
  ),
];
