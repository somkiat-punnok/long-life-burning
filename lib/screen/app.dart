import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:long_life_burning/widgets/nav.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  // _AppState() {
  // }
  
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
      home: NavBar(),
    );

  }

}
