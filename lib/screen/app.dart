import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:long_life_burning/routes/route.dart';
import 'package:long_life_burning/widgets/nav.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  Widget build(BuildContext context) {

    return PlatformApp(
      android: (_) => new MaterialAppData(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          platform: TargetPlatform.android,
        ),
        routes: Routes.route,
        home: NavBar(),
      ),
      ios: (_) => new CupertinoAppData(
        debugShowCheckedModeBanner: false,
        theme: CupertinoThemeData(
          primaryColor: CupertinoColors.activeBlue,
        ),
        routes: Routes.route,
        home: NavBar(),
      ),
    );

  }

}
