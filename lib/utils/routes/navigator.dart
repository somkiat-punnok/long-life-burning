import 'package:flutter/material.dart';
import 'route.dart';

enum CategoryPage { stepCount, nearby, events, groups, others }

class NavCategory {

  NavCategory({
    @required this.name,
    this.icon,
    @required this.tag,
    GlobalKey<NavigatorState> navigatorKey,
  }) :  navigateKey = navigatorKey ?? GlobalKey<NavigatorState>(),
        assert(name != null);

  final String name;
  final IconData icon;
  final CategoryPage tag;
  final GlobalKey<NavigatorState> navigateKey;

  @override
  String toString() {
    return '$runtimeType($name)';
  }

}

class Pages {

  Pages({
    @required this.name,
    @required this.tag,
    @required this.routeName,
    @required this.buildRoute,
  }) :  assert(tag != null),
        assert(name != null),
        assert(routeName != null),
        assert(buildRoute != null);

  final String name;
  final CategoryPage tag;
  final String routeName;
  final WidgetBuilder buildRoute;

  @override
  String toString() {
    return '$runtimeType($name, $tag, $routeName, $buildRoute)';
  }

}

class PageNavigate extends StatelessWidget {

  PageNavigate({
    Key key,
    @required this.index,
  }) :  assert(index != null),
        super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) => Navigator(
    key: nav[index].navigateKey,
    initialRoute: '/',
    onGenerateRoute: (RouteSettings settings) => MaterialPageRoute(
      settings: settings,
      builder: _buildRoutePage(nav[index].tag)[settings.name],
    ),
  );
}



Map<String, WidgetBuilder> _buildRoutePage(CategoryPage i) => Map<String, WidgetBuilder>.fromIterable(
  listPageCategory[i],
  key: (dynamic page) => page.routeName,
  value: (dynamic page) => page.buildRoute,
);
