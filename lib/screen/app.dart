import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:long_life_burning/routes/route.dart';
import 'package:long_life_burning/routes/route_app.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  _AppState() {
    final router = new Router();
    Routes.configRoute(router);
    Application.router = router;
  }
  
  @override
  Widget build(BuildContext context) {

    final themeData = new ThemeData(
      primarySwatch: Colors.blue,
    );

    final cupertinoTheme = new CupertinoThemeData(
      primaryColor: Colors.blue,
    );

    return PlatformApp(
      android: (_) => new MaterialAppData(theme: themeData),
      ios: (_) => new CupertinoAppData(theme: cupertinoTheme),
      onGenerateRoute: Application.router.generator,
    );

  }

}
